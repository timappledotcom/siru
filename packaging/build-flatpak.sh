#!/bin/bash
set -e

echo "Building Siru Flatpak..."
echo "This process may take several minutes as it builds Ruby from source."

# Create build directory
mkdir -p release/flatpak

# Build the Flatpak
flatpak-builder --repo=release/flatpak/repo --force-clean release/flatpak/build-dir packaging/flatpak/com.github.timappledotcom.siru.json

# Create bundle
flatpak build-bundle release/flatpak/repo release/flatpak/siru.flatpak com.github.timappledotcom.siru

echo "Flatpak built successfully: release/flatpak/siru.flatpak"
echo ""
echo "To install the Flatpak locally:"
echo "  flatpak install --user release/flatpak/siru.flatpak"
echo ""
echo "To run Siru from Flatpak:"
echo "  flatpak run com.github.timappledotcom.siru"
