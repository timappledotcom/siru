# Siru v0.2.1 - Initial Release

Siru is a Hugo-inspired static site generator built in Ruby.

## Features

- **Markdown Processing**: Full markdown support with TOML/YAML front matter
- **Theme System**: Extensible theme system with Liquid templating
- **Built-in Paper Theme**: Clean, responsive theme inspired by Hugo Paper
- **Live Development Server**: Built-in server with file watching and auto-reload
- **Static Asset Handling**: Automatic copying of static files and assets
- **Command Line Interface**: Simple CLI with `new`, `build`, and `serve` commands

## Installation

### From .deb Package (Debian/Ubuntu)
```bash
wget https://github.com/timappledotcom/siru/releases/download/v0.2.1/siru_0.2.1_all.deb
sudo dpkg -i siru_0.2.1_all.deb
sudo apt-get install -f  # Fix any dependency issues
```

### From Source
```bash
wget https://github.com/timappledotcom/siru/releases/download/v0.2.1/siru-0.2.1.tar.gz
tar -xzf siru-0.2.1.tar.gz
cd siru-0.2.1
bundle install
```

### Flatpak (Advanced)
Flatpak manifest and build scripts are included in this release. See [FLATPAK.md](FLATPAK.md) for detailed build instructions.

```bash
# Extract Flatpak files
wget https://github.com/timappledotcom/siru/releases/download/v0.2.1/siru-0.2.1-flatpak.tar.gz
tar -xzf siru-0.2.1-flatpak.tar.gz
# Follow instructions in FLATPAK.md
```

## Usage

```bash
# Create a new site
siru new mysite

# Build the site
cd mysite
siru build

# Serve with live reload
siru serve -w
```

## Documentation

- [README.md](https://github.com/timappledotcom/siru/blob/main/README.md)
- [Theme Creation Guide](https://github.com/timappledotcom/siru/blob/main/THEME_CREATION.md)

## What's Next

- Package managers (Flatpak, Snap, etc.)
- More themes
- Plugin system
- Performance optimizations
