# Siru v0.2.0 - New Post Command

## New Features

### 🚀 Enhanced CLI with New Post Command
- **New Command**: `siru new post "Post Title"` - Automatically creates and opens posts in your editor
- **Draft Support**: `siru new post "Draft Title" --draft` - Create draft posts with the draft flag
- **Editor Integration**: Automatically opens new posts in your preferred editor (`$EDITOR`, `$VISUAL`, or `nano`)
- **Smart File Naming**: Converts titles to SEO-friendly filenames (e.g., "My Post" → "my-post.md")
- **Proper Front Matter**: Automatically generates TOML front matter with title, date, and draft status

### 🔧 Improvements
- **Better Error Handling**: More informative error messages for invalid commands
- **Updated Documentation**: Complete usage instructions for all features
- **Enhanced Help**: Updated help text to include new commands

## Usage

```bash
# Create a new site
siru new mysite

# Navigate to your site
cd mysite

# Create a new post (opens in editor)
siru new post "Getting Started with Siru"

# Create a draft post
siru new post "Work in Progress" --draft

# Build your site
siru build

# Serve with live reload
siru serve --watch
```

## Installation

### Via APT Repository (Ubuntu/Debian)
```bash
# Add the repository
echo "deb [trusted=yes arch=amd64] https://raw.githubusercontent.com/timappledotcom/siru-apt-repo/main/ stable main" | sudo tee /etc/apt/sources.list.d/siru.list

# Update and install
sudo apt update
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

## What's Changed
- Enhanced CLI with new post creation workflow
- Improved user experience with automatic editor integration
- Better file organization and naming conventions
- Updated documentation with comprehensive usage examples

## Contributors
- @timappledotcom

---

**Full Changelog**: https://github.com/timappledotcom/siru/compare/v0.1.0...v0.2.0
