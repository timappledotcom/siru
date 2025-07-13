# Flatpak Packaging for Siru

This directory contains the Flatpak manifest and build scripts for creating a Flatpak package of Siru.

## Files

- `com.github.timappledotcom.siru.json`: Main Flatpak manifest
- `com.github.timappledotcom.siru.simple.json`: Simplified manifest (experimental)
- `build-flatpak.sh`: Build script for creating the Flatpak

## Building

### Prerequisites

1. Install Flatpak and flatpak-builder:
   ```bash
   sudo apt install flatpak flatpak-builder
   ```

2. Add Flathub repository:
   ```bash
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

3. Install required runtimes:
   ```bash
   sudo flatpak install flathub org.freedesktop.Platform//23.08 org.freedesktop.Sdk//23.08
   ```

### Build Process

Run the build script:
```bash
./packaging/build-flatpak.sh
```

This will:
1. Build Ruby from source (takes several minutes)
2. Install Siru and its dependencies
3. Create a Flatpak bundle

### Installation

Once built, install the Flatpak:
```bash
flatpak install --user release/flatpak/siru.flatpak
```

### Usage

Run Siru from Flatpak:
```bash
flatpak run com.github.timappledotcom.siru new mysite
```

## Notes

- The Flatpak build process is complex due to Ruby compilation
- The build requires network access to download Ruby and gems
- The resulting Flatpak is self-contained and doesn't require system Ruby
- File system access is limited to the user's home directory for security

## Future Improvements

- Consider using a pre-built Ruby runtime
- Optimize build time by caching dependencies
- Add desktop integration files
- Submit to Flathub for easier distribution
