-- ============================================================
-- Daily15 · Gauntlet standings
-- Paste this whole file into Supabase → SQL Editor → Run.
-- Safe to run more than once.
--
-- How it stays honest:
--   * Players never touch the table directly (row level security on, no policies).
--     The site can only call the three functions below.
--   * The server stamps the start time. A finish is accepted only if the
--     reported clock fits inside the real time that passed on the server.
--   * One official run per player per day (refreshing mid-run keeps the
--     original start time, so restarting doesn't reset the clock).
-- No accounts needed: each browser gets a random player id, and players
-- pick a nickname for the board.
-- ============================================================

create table if not exists public.gauntlet_runs (
  id           uuid primary key default gen_random_uuid(),
  run_date     date        not null,               -- the player's local date (puzzle of the day)
  player_id    uuid        not null,               -- random id kept in the player's browser
  nickname     text,
  started_at   timestamptz not null default now(), -- stamped by the server, not the phone
  finished_at  timestamptz,
  clock_ms     integer,                            -- stopwatch time reported by the game
  penalty_s    integer,
  total_ms     integer,                            -- clock + penalties: what the board ranks
  skipped      smallint,
  splits       jsonb,                              -- per-game times, for the results bar
  status       text not null default 'started'
               check (status in ('started', 'finished', 'flagged')),
  unique (run_date, player_id)
);

create index if not exists gauntlet_board_idx
  on public.gauntlet_runs (run_date, total_ms) where status = 'finished';

alter table public.gauntlet_runs enable row level security;
revoke all on public.gauntlet_runs from anon, authenticated;

-- ---------- 1. Start (or resume) today's run ----------
-- Returns the run id, or null if this player already finished today.
create or replace function public.gauntlet_start(p_player uuid, p_date date)
returns uuid
language plpgsql security definer set search_path = public
as $$
declare
  v_id uuid;
  v_utc date := (now() at time zone 'utc')::date;
begin
  if p_date is null or p_date < v_utc - 1 or p_date > v_utc + 1 then
    raise exception 'date out of range';
  end if;

  insert into gauntlet_runs (run_date, player_id)
  values (p_date, p_player)
  on conflict (run_date, player_id) do nothing
  returning id into v_id;

  if v_id is null then                                   -- already has a row today
    select id into v_id from gauntlet_runs
     where run_date = p_date and player_id = p_player and status = 'started';
  end if;
  return v_id;
end;
$$;

-- ---------- 2. Finish the run ----------
-- Returns the player's rank, how many finished today, and their total.
create or replace function public.gauntlet_finish(
  p_run uuid, p_player uuid, p_nickname text,
  p_clock_ms integer, p_penalty_s integer, p_skipped integer, p_splits jsonb)
returns table (rank bigint, players bigint, total_ms integer)
language plpgsql security definer set search_path = public
as $$
declare
  r       gauntlet_runs%rowtype;
  v_wall  bigint;
  v_ok    boolean;
  v_name  text;
  v_total integer;
begin
  select * into r from gauntlet_runs g
   where g.id = p_run and g.player_id = p_player
   for update;
  if not found or r.status <> 'started' then
    raise exception 'no open run';
  end if;

  v_wall := floor(extract(epoch from (now() - r.started_at)) * 1000);
  -- the game's clock pauses between stages, so it can only be shorter than real time
  v_ok := p_clock_ms between 15000 and v_wall + 2000
          and p_penalty_s between 0 and 1000
          and p_skipped between 0 and 7;

  v_name := left(regexp_replace(coalesce(trim(p_nickname), ''), '[^A-Za-z0-9 _.\-]', '', 'g'), 16);
  if v_name = '' then v_name := 'Player'; end if;
  v_total := p_clock_ms + p_penalty_s * 1000;

  update gauntlet_runs g set
    finished_at = now(), nickname = v_name,
    clock_ms = p_clock_ms, penalty_s = p_penalty_s, total_ms = v_total,
    skipped = p_skipped, splits = p_splits,
    status = case when v_ok then 'finished' else 'flagged' end
  where g.id = p_run;

  -- a flagged run gets no rank (it isn't on the board)
  return query
    select case when v_ok then (select count(*) + 1 from gauntlet_runs x
             where x.run_date = r.run_date and x.status = 'finished' and x.total_ms < v_total) end,
           (select count(*) from gauntlet_runs x
             where x.run_date = r.run_date and x.status = 'finished'),
           v_total;
end;
$$;

-- ---------- 3. Today's board ----------
create or replace function public.gauntlet_board(p_date date, p_limit integer default 50)
returns table (rank bigint, nickname text, total_ms integer, skipped smallint)
language sql stable security definer set search_path = public
as $$
  select rank() over (order by g.total_ms), g.nickname, g.total_ms, g.skipped
    from gauntlet_runs g
   where g.run_date = p_date and g.status = 'finished'
   order by g.total_ms
   limit least(greatest(p_limit, 1), 100);
$$;

revoke all on function public.gauntlet_start(uuid, date) from public;
revoke all on function public.gauntlet_finish(uuid, uuid, text, integer, integer, integer, jsonb) from public;
revoke all on function public.gauntlet_board(date, integer) from public;
grant execute on function public.gauntlet_start(uuid, date) to anon, authenticated;
grant execute on function public.gauntlet_finish(uuid, uuid, text, integer, integer, integer, jsonb) to anon, authenticated;
grant execute on function public.gauntlet_board(date, integer) to anon, authenticated;
