# Siru Default Theme

The modern, configurable theme for Siru static site generator with support for multiple color schemes and fonts.

## Features

- **7 Beautiful Color Schemes**: Choose from Catppuccin (4 variants), Nord, Dracula, and Tokyo Night
- **10 Popular Fonts**: Sans-serif, serif, and monospace options
- **Responsive Design**: Mobile-first approach with clean layouts
- **Dark/Light Support**: Automatic adaptation based on color scheme
- **Pure CSS**: No framework dependencies, fast loading
- **Semantic HTML**: Clean, accessible markup
- **Social Media Integration**: Support for Twitter, GitHub, Mastodon, Bluesky, Nostr, and RSS

## Color Schemes

Set in `config.toml` with `theme = "scheme-name"`:

### Catppuccin
```toml
theme = "catppuccin-mocha"     # Dark theme with purple accents (default)
theme = "catppuccin-latte"     # Light theme with blue accents
theme = "catppuccin-macchiato" # Dark theme with softer colors
theme = "catppuccin-frappe"    # Dark theme with muted tones
```

### Other Themes
```toml
theme = "nord"        # Minimal dark theme with blue accents
theme = "dracula"     # Dark theme with vibrant colors
theme = "tokyo-night" # Dark theme with purple and blue accents
```

## Font Options

Set in `config.toml` with `font = "font-name"`:

### Sans-serif (Modern & Clean)
```toml
font = "inter"      # Modern, highly readable (default)
font = "helvetica"  # Classic, professional
font = "open-sans"  # Friendly, readable
font = "roboto"     # Clean, geometric
font = "lato"       # Friendly, approachable
```

### Serif (Traditional & Elegant)
```toml
font = "georgia"         # Classic web serif
font = "merriweather"    # Optimized for reading
font = "playfair"        # Elegant, high-contrast
font = "crimson-text"    # Academic, scholarly
```

### Monospace (Code-focused)
```toml
font = "source-code-pro" # Optimized for code display
```

## Configuration Examples

### Basic Configuration
```toml
[params]
  theme = "catppuccin-mocha"  # Color scheme (default)
  font = "inter"              # Font family (default)
```

### Popular Combinations

#### Academic/Professional
```toml
[params]
  theme = "catppuccin-latte"   # Light, professional theme
  font = "georgia"             # Traditional serif font
  bio = "Research and thoughts on computer science"
```

#### Developer Blog
```toml
[params]
  theme = "dracula"            # Vibrant dark theme
  font = "source-code-pro"     # Monospace font
  bio = "Code, tutorials, and tech insights"
```

#### Minimal Design
```toml
[params]
  theme = "nord"               # Clean, minimal theme
  font = "helvetica"           # Classic sans-serif
  bio = "Thoughts and ideas"
```

#### Creative Writing
```toml
[params]
  theme = "tokyo-night"        # Atmospheric dark theme
  font = "playfair"            # Elegant serif font
  bio = "Stories, poetry, and creative writing"
```

### Full Configuration
```toml
[params]
  # Theme customization
  theme = "catppuccin-mocha"  # Color scheme
  font = "inter"              # Font family
  
  # Optional bio section
  bio = "Welcome to my blog!"
  
  # Social links (all optional)
  twitter = "yourusername"
  github = "yourusername"
  mastodon = "https://mastodon.social/@yourusername"
  bluesky = "yourusername.bsky.social"
  nostr = "npub1yourkey..."
```

## Usage

Siru comes with this theme by default. Simply:

1. Choose your preferred color scheme and font in `config.toml`
2. Customize social links and bio as needed
3. Start creating content!

## Browser Support

The theme uses modern CSS features with fallbacks:
- CSS Custom Properties (CSS Variables)
- CSS Grid and Flexbox
- Modern font loading
- Responsive design

Supported browsers:
- Chrome/Edge 49+
- Firefox 31+
- Safari 9.1+

## Theme Switching

The theme includes JavaScript for runtime theme switching:

```javascript
// Change color scheme
setTheme('dracula');

// Change font
setFont('georgia');
```

Settings are automatically saved to localStorage and persist across sessions.

## Customization

### Adding New Color Schemes

To add a new color scheme, define CSS custom properties:

```css
[data-theme="my-theme"] {
  --color-bg: #your-bg-color;
  --color-text: #your-text-color;
  --color-primary: #your-primary-color;
  /* ... other colors */
}
```

### Adding New Fonts

1. Add the font import to the CSS
2. Define the font variable
3. Add the font to the JavaScript arrays

## Performance

- **Fast Loading**: No external frameworks
- **Optimized Fonts**: Google Fonts with `display=swap`
- **Minimal CSS**: Only essential styles
- **Responsive Images**: Automatic scaling

## Accessibility

- Semantic HTML structure
- Proper color contrast ratios
- Keyboard navigation support
- Screen reader friendly
- Focus indicators

## License

This theme is part of the Siru static site generator and follows the same GPL-3.0 license.
