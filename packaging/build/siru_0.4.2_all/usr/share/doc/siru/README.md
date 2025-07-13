# Siru

Siru is a static site generator inspired by [Hugo](https://gohugo.io/), built with Ruby.

## Features
- Markdown content rendering
- Theme support
- Live server with reload

## Installation

### Via APT Repository (Ubuntu/Debian)

```bash
# Add the repository
echo "deb [trusted=yes arch=amd64] https://raw.githubusercontent.com/timappledotcom/siru-apt-repo/main/ stable main" | sudo tee /etc/apt/sources.list.d/siru.list

# Update package list
sudo apt update

# Install Siru
sudo apt install siru
```

### Via .deb Package

```bash
wget https://github.com/timappledotcom/siru/releases/download/v0.2.0/siru_0.2.0_all.deb
sudo dpkg -i siru_0.2.0_all.deb
```

### Via Flatpak

```bash
flatpak install --user siru-0.2.0.flatpak
```

## Usage

1. **Create a new site**
   ```
   siru new [sitename]
   ```

2. **Create a new post**
   
   **Quick method (auto-generates and opens in editor):**
   ```
   siru new post "My Post Title"
   siru new post "My Draft Post" --draft
   ```
   
   This command will:
   - Create a new markdown file in `content/posts/`
   - Generate a filename from the title (e.g., "my-post-title.md")
   - Add proper front matter with title, date, and draft status
   - Open the file in your default editor (set via `$EDITOR` or `$VISUAL`)
   
   **Manual method:**
   - Navigate to the `content/posts/` directory.
   - Create a new Markdown file with TOML or YAML front matter:
   
   ```toml
   +++
   title = "My Awesome Post"
   date = "2025-07-14"
   draft = true
   +++
   
   Content goes here.
   ```

3. **Create a new page**
   - Navigate to the `content/` directory (not inside `posts`).
   - Create a new Markdown file:

   ```toml
   +++
   title = "About Us"
   date = "2025-07-14"
   draft = true
   +++

   About us content.
   ```

4. **Build the site**
   ```
   cd [sitename]
   siru build
   ```

5. **Serve the site**
   ```
   siru serve
   ```

### Drafts

- **Draft Mode**: To include draft posts in your build or serve, add the `--draft` option.

```bash
siru build --draft
siru serve --draft
```

- **Draft Status**: Posts with `draft = true` in their front matter will not be published unless the `--draft` option is used.

## Configuration

Siru sites are configured through a `config.toml` file in the root directory:

```toml
baseURL = "https://yoursite.com/"
languageCode = "en-us"
title = "My Awesome Site"
theme = "paper"

[params]
color = "linen"  # Theme color: linen, wheat, gray, light
bio = "Welcome to my blog!"
twitter = "yourusername"
github = "yourusername"
mastodon = "https://mastodon.social/@yourusername"
bluesky = "yourusername.bsky.social"
```

## Front Matter

Siru supports both TOML and YAML front matter:

### TOML Front Matter
```toml
+++
title = "Post Title"
date = "2025-07-14"
draft = false
tags = ["ruby", "static-site"]
summary = "A brief summary of the post"
+++
```

### YAML Front Matter
```yaml
---
title: "Post Title"
date: "2025-07-14"
draft: false
tags: ["ruby", "static-site"]
summary: "A brief summary of the post"
---
```

### Available Front Matter Fields
- `title`: Post/page title
- `date`: Publication date (supports both date and datetime formats)
- `draft`: Whether the content is a draft (true/false)
- `tags`: Array of tags for the post
- `summary`: Brief description (used in post lists)
- `slug`: Custom URL slug (optional)

#### Date and Time Support

Siru supports both date-only and datetime formats for the `date` field:

```toml
# Date only
date = "2025-07-14"

# Date with time
date = "2025-07-14T14:30:00"
date = "2025-07-14 14:30:00"
```

When using datetime format, the time component is preserved and can be used for sorting posts and displaying in themes.

## License

This project is licensed under the terms of the [GPL-3.0 license](LICENSE).
