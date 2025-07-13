#!/bin/bash
set -e

VERSION="0.2.1"
RELEASE_DIR="release"

echo "Creating Siru v${VERSION} release..."

# Clean previous releases
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

# Build .deb package
echo "Building .deb package..."
./packaging/build-deb.sh
cp packaging/build/siru_${VERSION}_all.deb "$RELEASE_DIR/"

# Create source tarball
echo "Creating source tarball..."
git archive --format=tar.gz --prefix=siru-${VERSION}/ HEAD > "$RELEASE_DIR/siru-${VERSION}.tar.gz"

# Copy Flatpak files for distribution
echo "Copying Flatpak files..."
cp -r packaging/flatpak "$RELEASE_DIR/"
cp packaging/FLATPAK.md "$RELEASE_DIR/"

# Create Flatpak tarball
echo "Creating Flatpak tarball..."
tar -czf "$RELEASE_DIR/siru-${VERSION}-flatpak.tar.gz" -C packaging flatpak FLATPAK.md

# Create release notes
cat > "$RELEASE_DIR/RELEASE_NOTES.md" << EOF
# Siru v${VERSION} - Initial Release

Siru is a Hugo-inspired static site generator built in Ruby.

## Features

- **Markdown Processing**: Full markdown support with TOML/YAML front matter
- **Theme System**: Extensible theme system with Liquid templating
- **Built-in Paper Theme**: Clean, responsive theme inspired by Hugo Paper
- **Live Development Server**: Built-in server with file watching and auto-reload
- **Static Asset Handling**: Automatic copying of static files and assets
- **Command Line Interface**: Simple CLI with \`new\`, \`build\`, and \`serve\` commands

## Installation

### From .deb Package (Debian/Ubuntu)
\`\`\`bash
wget https://github.com/timappledotcom/siru/releases/download/v${VERSION}/siru_${VERSION}_all.deb
sudo dpkg -i siru_${VERSION}_all.deb
sudo apt-get install -f  # Fix any dependency issues
\`\`\`

### From Source
\`\`\`bash
wget https://github.com/timappledotcom/siru/releases/download/v${VERSION}/siru-${VERSION}.tar.gz
tar -xzf siru-${VERSION}.tar.gz
cd siru-${VERSION}
bundle install
\`\`\`

### Flatpak (Advanced)
Flatpak manifest and build scripts are included in this release. See [FLATPAK.md](FLATPAK.md) for detailed build instructions.

\`\`\`bash
# Extract Flatpak files
wget https://github.com/timappledotcom/siru/releases/download/v${VERSION}/siru-${VERSION}-flatpak.tar.gz
tar -xzf siru-${VERSION}-flatpak.tar.gz
# Follow instructions in FLATPAK.md
\`\`\`

## Usage

\`\`\`bash
# Create a new site
siru new mysite

# Build the site
cd mysite
siru build

# Serve with live reload
siru serve -w
\`\`\`

## Documentation

- [README.md](https://github.com/timappledotcom/siru/blob/main/README.md)
- [Theme Creation Guide](https://github.com/timappledotcom/siru/blob/main/THEME_CREATION.md)

## What's Next

- Package managers (Flatpak, Snap, etc.)
- More themes
- Plugin system
- Performance optimizations
EOF

echo "Release files created in $RELEASE_DIR/"
echo "Contents:"
ls -la "$RELEASE_DIR/"
