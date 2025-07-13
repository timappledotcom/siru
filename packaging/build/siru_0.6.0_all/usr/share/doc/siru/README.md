# Siru

A modern static site generator inspired by [Hugo](https://gohugo.io/), built with Ruby. Features a unified theme system with multiple color schemes, fonts, and responsive design.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Creating Content](#creating-content)
  - [Working with Drafts](#working-with-drafts)
- [Configuration](#configuration)
  - [Site Configuration](#site-configuration)
  - [Theme Configuration](#theme-configuration)
- [Front Matter](#front-matter)
- [Themes](#themes)
- [Documentation](#documentation)
- [License](#license)

## Features

- **Markdown Content**: Full Markdown support with TOML/YAML front matter
- **Unified Theme System**: One theme with 7 color schemes and 10 fonts
- **Live Development Server**: Auto-reload during development
- **Draft Support**: Build with or without draft content
- **Responsive Design**: Mobile-first, accessible layouts
- **Social Integration**: Built-in support for Twitter, GitHub, Mastodon, Bluesky, Nostr
- **Fast Performance**: Pure CSS, no framework dependencies

## Installation

### Via APT Repository (Ubuntu/Debian)

```bash
# Add repository
echo "deb [trusted=yes arch=amd64] https://raw.githubusercontent.com/timappledotcom/siru-apt-repo/main/ stable main" | sudo tee /etc/apt/sources.list.d/siru.list

# Install
sudo apt update && sudo apt install siru
```

### Via .deb Package

```bash
wget https://github.com/timappledotcom/siru/releases/latest/download/siru.deb
sudo dpkg -i siru.deb
```

## Quick Start

```bash
# Create a new site
siru new myblog
cd myblog

# Create your first post
siru new post "Hello World"

# Start development server
siru serve

# Visit http://localhost:4000
```

## Usage

### Creating Content

#### New Site
```bash
siru new [sitename]
```

#### New Post (Automatic)
```bash
siru new post "My Post Title"        # Creates and opens in editor
siru new post "Draft Post" --draft   # Creates as draft
```

#### New Post (Manual)
Create `content/posts/my-post.md`:
```toml
+++
title = "My Post"
date = "2025-07-14"
draft = false
+++

Your content here.
```

#### New Page
Create `content/about.md`:
```toml
+++
title = "About"
date = "2025-07-14"
+++

About page content.
```

### Building and Serving

```bash
siru build        # Build to public/
siru serve        # Serve at http://localhost:4000
```

### Working with Drafts

```bash
siru build --draft   # Include drafts in build
siru serve --draft   # Include drafts in development
```

## Configuration

### Site Configuration

Edit `config.toml`:

```toml
baseURL = "https://yoursite.com/"
languageCode = "en-us"
title = "My Blog"

[params]
  bio = "Welcome to my blog!"
  
  # Social links (optional)
  twitter = "username"
  github = "username"
  mastodon = "https://mastodon.social/@username"
  bluesky = "username.bsky.social"
  nostr = "npub1..."
```

### Theme Configuration

The default theme supports multiple color schemes and fonts:

```toml
[params]
  # Color schemes: catppuccin-mocha (default), catppuccin-latte, 
  # catppuccin-macchiato, catppuccin-frappe, nord, dracula, tokyo-night
  theme = "catppuccin-mocha"
  
  # Fonts: inter (default), helvetica, open-sans, roboto, lato,
  # georgia, merriweather, playfair, crimson-text, source-code-pro
  font = "inter"
```

## Front Matter

Supports both TOML (`+++`) and YAML (`---`) front matter:

```toml
+++
title = "Post Title"
date = "2025-07-14"           # Or "2025-07-14T14:30:00"
draft = false
tags = ["ruby", "web"]
summary = "Brief description"
slug = "custom-url"           # Optional
+++
```

## Themes

Siru includes a unified default theme with:
- **7 Color Schemes**: Catppuccin variants, Nord, Dracula, Tokyo Night
- **10 Fonts**: Sans-serif, serif, and monospace options
- **Runtime Switching**: Change themes/fonts in browser
- **Responsive Design**: Mobile-first layouts

See [`themes/default/README.md`](themes/default/README.md) for complete theme documentation.

## Documentation

- **[Theme Documentation](themes/default/README.md)**: Complete theme configuration guide
- **[Theme Creation Guide](THEME_CREATION.md)**: How to create custom themes
- **[Changelog](CHANGELOG.md)**: Version history and updates

## License

GPL-3.0 License - see [LICENSE](LICENSE) file.
