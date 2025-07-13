# Siru Unified Theme

A modern, configurable theme for Siru static site generator with support for multiple color schemes and fonts.

## Features

- **7 Beautiful Color Schemes**: Choose from Catppuccin (4 variants), Nord, Dracula, and Tokyo Night
- **10 Popular Fonts**: Sans-serif, serif, and monospace options
- **Responsive Design**: Mobile-first approach with clean layouts
- **Dark/Light Support**: Automatic adaptation based on color scheme
- **Pure CSS**: No framework dependencies, fast loading
- **Semantic HTML**: Clean, accessible markup
- **Social Media Integration**: Support for Twitter, GitHub, Mastodon, Bluesky, Nostr, and RSS

## Color Schemes

### Catppuccin
- **Mocha** (default): Dark theme with purple accents
- **Latte**: Light theme with blue accents  
- **Macchiato**: Dark theme with softer colors
- **Frappé**: Dark theme with muted tones

### Other Themes
- **Nord**: Minimal dark theme with blue accents
- **Dracula**: Dark theme with vibrant colors
- **Tokyo Night**: Dark theme with purple and blue accents

## Font Options

### Sans-serif (Modern & Clean)
- **Inter** (default): Modern, highly readable
- **Helvetica**: Classic, professional
- **Open Sans**: Friendly, readable
- **Roboto**: Clean, geometric
- **Lato**: Friendly, approachable

### Serif (Traditional & Elegant)
- **Georgia**: Classic web serif
- **Merriweather**: Optimized for reading
- **Playfair Display**: Elegant, high-contrast
- **Crimson Text**: Academic, scholarly

### Monospace (Code-focused)
- **Source Code Pro**: Optimized for code display

## Configuration

Add these settings to your `config.toml`:

```toml
theme = "unified"

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

1. Copy the `unified` theme to your themes directory
2. Set `theme = "unified"` in your `config.toml`
3. Choose your preferred color scheme and font
4. Customize social links and bio as needed

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
