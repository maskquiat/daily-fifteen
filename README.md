# 15-Puzzle Daily

🧩 **A modern, responsive daily 15-puzzle game inspired by New York Times Games**

Play the classic sliding puzzle with a fresh daily challenge that everyone around the world gets to solve on the same day. Perfect for your morning routine or daily mental exercise!

## 🎮 Live Demo

[Play the game here](https://maskquiat.github.io/daily-fifteen/) *(Replace with your actual URL)*

## ✨ Features

### 🗓️ Daily Puzzle System
- **One puzzle per day**: Everyone gets the same puzzle each day
- **Consistent experience**: Seeded generation ensures identical puzzles globally
- **Progress tracking**: Your game automatically saves and can be resumed
- **Puzzle numbering**: Each day has a unique puzzle number for reference

### 📱 Cross-Platform Compatibility
- **Desktop/Laptop**: Click tiles to move them
- **Mobile/Tablet**: Tap tiles OR use intuitive swipe gestures
- **Responsive design**: Adapts beautifully to any screen size
- **Touch-optimized**: Smooth swipe controls for mobile users

### 🎯 Game Features
- **Move counter**: Track your efficiency
- **Timer**: See how fast you can solve it
- **Visual feedback**: Green highlighting shows moveable tiles
- **Win detection**: Celebration when you complete the puzzle
- **Share results**: Share your daily score with friends

### 🎨 Modern UI/UX
- **Glassmorphism design**: Modern, premium visual style
- **Smooth animations**: Satisfying tile movements and interactions
- **Dark theme**: Easy on the eyes for any time of day
- **Accessibility**: High contrast and clear typography

## 🚀 Quick Start

### Option 1: Download and Play Locally
1. Clone this repository:
```bash
git clone https://github.com/maskquiat/15-puzzle-daily.git
cd 15-puzzle-daily
```

2. Open `index.html` in your web browser
3. Start playing immediately!

### Option 2: Deploy to Production
1. **Vercel** (Recommended):
   - Fork this repository
   - Connect to Vercel
   - Deploy with one click
   - Add custom domain

2. **Netlify**:
   - Drag and drop the files to Netlify
   - Configure custom domain
   - Enable form handling (if needed)

3. **GitHub Pages**:
   - Enable GitHub Pages in repository settings
   - Select source branch
   - Access via `maskquiat.github.io/daily-fifteen`

## 🎲 How to Play

1. **Load Today's Puzzle**: Click "Today's Puzzle" to get the daily challenge
2. **Move Tiles**: Click tiles adjacent to the empty space to slide them
3. **Mobile Gestures**: Swipe in the direction you want to move the empty space
4. **Goal**: Arrange numbers 1-15 in order with the empty space in the bottom-right
5. **Share**: After completing, share your score with friends!

## 🛠️ Technology Stack

- **Frontend**: Pure HTML5, CSS3, JavaScript (ES6+)
- **Storage**: localStorage for progress persistence
- **Responsive**: CSS Grid and Flexbox
- **Cross-platform**: Touch and mouse event handling
- **No dependencies**: Runs entirely in the browser

## 📊 Game Mechanics

### Puzzle Generation
- **Seeded randomization**: Uses date as seed for consistent daily puzzles
- **Solvability guarantee**: Algorithm ensures every puzzle is solvable
- **Difficulty consistency**: ~1000 randomized moves for balanced challenge

### Progress Persistence
- **Auto-save**: Progress automatically saved after each move
- **Resume capability**: Continue where you left off
- **Daily tracking**: Separate progress for each day's puzzle

### Sharing Format
```
Daily 15-Puzzle #123
Solved in 45 moves
Time: 2:34
Try it yourself!
```

## 🎨 Customization

### Modify Colors
Edit the CSS variables in the `<style>` section:
```css
/* Main gradient */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Tile colors */
background: linear-gradient(145deg, #ffffff, #e6e6e6);

/* Button colors */
background: linear-gradient(145deg, #4CAF50, #45a049);
```

### Adjust Difficulty
Modify the shuffle amount in the JavaScript:
```javascript
const shuffleMoves = 1000; // Increase for harder puzzles
```

### Change Puzzle Size
Currently supports 4×4 (15-puzzle). Can be modified for different sizes:
- 3×3 (8-puzzle): Change grid to `repeat(3, 1fr)`
- 5×5 (24-puzzle): Change grid to `repeat(5, 1fr)`

## 📈 Analytics Integration

Ready for analytics integration:

### Google Analytics 4
```html
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### Custom Events
```javascript
// Track puzzle completion
gtag('event', 'puzzle_complete', {
  'moves': moves,
  'time_seconds': timeSeconds,
  'puzzle_number': getPuzzleNumber()
});
```

## 🔧 Development

### File Structure
```
15-puzzle-daily/
├── index.html          # Complete game (HTML, CSS, JS)
├── README.md          # This file
└── assets/            # Optional: images, icons
```

### Key Functions
- `loadDailyPuzzle()`: Generates today's seeded puzzle
- `moveTile(index)`: Handles tile movement logic
- `saveProgress()`: Persists game state
- `shareResult()`: Creates shareable score text

### Browser Support
- **Modern browsers**: Chrome 60+, Firefox 55+, Safari 12+, Edge 79+
- **Mobile browsers**: iOS Safari 12+, Chrome Mobile 60+
- **Features used**: localStorage, CSS Grid, Touch Events

## 🎯 Roadmap

### Version 2.0 Features
- [ ] User accounts and leaderboards
- [ ] Weekly and monthly challenges
- [ ] Achievement system
- [ ] Puzzle size variations (8-puzzle, 24-puzzle)
- [ ] Themes and customization
- [ ] Social sharing improvements
- [ ] Progressive Web App (PWA)

### Monetization Ready
- [ ] Premium subscription tiers
- [ ] Ad integration points
- [ ] Analytics dashboard
- [ ] A/B testing framework

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Areas for Contribution
- UI/UX improvements
- Performance optimizations
- Additional puzzle sizes
- Accessibility enhancements
- Mobile experience improvements
- Analytics integration

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the classic 15-puzzle invented in the 1870s
- Design patterns from New York Times Games
- Modern web development best practices
- Community feedback and contributions

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/maskquiat/15-puzzle-daily/issues)
- **Discussions**: [GitHub Discussions](https://github.com/maskquiat/15-puzzle-daily/discussions)
- **Email**: maskquiat@gmail.com

---

**⭐ If you enjoyed this game, please star the repository and share it with friends!**

Made with ❤️ for puzzle enthusiasts everywhere.
