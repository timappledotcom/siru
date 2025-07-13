#!/bin/bash
set -e

# Siru Automated Release Script
# This script builds a new Debian package and updates the APT repository

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [[ ! -f "$PROJECT_ROOT/siru.gemspec" ]]; then
    error "This script must be run from the Siru project root or scripts directory"
    exit 1
fi

cd "$PROJECT_ROOT"

# Get current version from lib/siru.rb
CURRENT_VERSION=$(grep -oP 'VERSION = "\K[^"]+' lib/siru.rb)
info "Current version: $CURRENT_VERSION"

# Prompt for new version if not provided
if [[ $# -eq 0 ]]; then
    echo -n "Enter new version (current: $CURRENT_VERSION): "
    read NEW_VERSION
else
    NEW_VERSION=$1
fi

if [[ -z "$NEW_VERSION" ]]; then
    error "Version cannot be empty"
    exit 1
fi

info "Building release for version $NEW_VERSION"

# Update version in files
info "Updating version in source files..."
sed -i "s/VERSION = \".*\"/VERSION = \"$NEW_VERSION\"/" lib/siru.rb
sed -i "s/spec.version = \".*\"/spec.version = \"$NEW_VERSION\"/" siru.gemspec
sed -i "s/VERSION=\".*\"/VERSION=\"$NEW_VERSION\"/" packaging/build-deb.sh
sed -i "s/Version: .*/Version: $NEW_VERSION/" packaging/debian/control

# Build gem
info "Building Ruby gem..."
gem build siru.gemspec

# Build Debian package
info "Building Debian package..."
chmod +x packaging/build-deb.sh
./packaging/build-deb.sh

# Check if APT repo directory exists
if [[ -d "apt-repo" ]]; then
    info "Updating APT repository..."
    
    # Copy package to APT repo
    cp "packaging/build/siru_${NEW_VERSION}_all.deb" "apt-repo/pool/main/s/siru/"
    
    # Update APT repository
    cd apt-repo
    ./update-repo.sh
    
    # Commit changes to APT repo (if it's a git repository)
    if [[ -d ".git" ]]; then
        info "Committing APT repository changes..."
        git add .
        git commit -m "Automated release of Siru v$NEW_VERSION

- Add siru_${NEW_VERSION}_all.deb package
- Update repository metadata and package indices"
        
        echo -n "Push APT repository changes to GitHub? (y/N): "
        read PUSH_APT
        if [[ "$PUSH_APT" == "y" || "$PUSH_APT" == "Y" ]]; then
            git push origin main
            info "APT repository updated on GitHub"
        else
            warn "APT repository changes not pushed. Run 'git push' manually in apt-repo/"
        fi
    fi
    
    cd "$PROJECT_ROOT"
else
    warn "APT repository directory not found. Skipping APT repository update."
fi

# Create git tag and commit
info "Creating git commit and tag..."
git add -A
git commit -m "Release v$NEW_VERSION

- Updated version to $NEW_VERSION
- Built gem and Debian packages"

git tag -a "v$NEW_VERSION" -m "Release v$NEW_VERSION"

echo -n "Push changes and tag to GitHub? (y/N): "
read PUSH_MAIN
if [[ "$PUSH_MAIN" == "y" || "$PUSH_MAIN" == "Y" ]]; then
    git push origin main
    git push origin "v$NEW_VERSION"
    info "Changes and tag pushed to GitHub"
else
    warn "Changes not pushed. Run 'git push origin main && git push origin v$NEW_VERSION' manually"
fi

# Summary
info "Release process completed!"
echo
echo "Built files:"
echo "  - siru-$NEW_VERSION.gem"
echo "  - packaging/build/siru_${NEW_VERSION}_all.deb"
if [[ -d "apt-repo" ]]; then
    echo "  - Updated APT repository"
fi
echo
info "Next steps:"
echo "  1. Create GitHub release at: https://github.com/timappledotcom/siru/releases/new"
echo "  2. Upload the built files as release assets"
echo "  3. Test installation with: sudo apt update && sudo apt upgrade siru"
