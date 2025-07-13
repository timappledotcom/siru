#!/bin/bash
set -e

VERSION="0.2.0"
PACKAGE_DIR="siru_${VERSION}_all"
BUILD_DIR="packaging/build"

echo "Building Siru .deb package..."

# Clean previous builds
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/$PACKAGE_DIR"

# Create directory structure
mkdir -p "$BUILD_DIR/$PACKAGE_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/$PACKAGE_DIR/usr/bin"
mkdir -p "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru"
mkdir -p "$BUILD_DIR/$PACKAGE_DIR/usr/share/doc/siru"

# Copy control files
cp packaging/debian/control "$BUILD_DIR/$PACKAGE_DIR/DEBIAN/"
cp packaging/debian/postinst "$BUILD_DIR/$PACKAGE_DIR/DEBIAN/"

# Copy application files
cp -r lib "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/"
cp -r themes "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/"
cp Gemfile "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/"
cp Gemfile.lock "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/"
cp siru.gemspec "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/"

# Copy documentation
cp README.md "$BUILD_DIR/$PACKAGE_DIR/usr/share/doc/siru/"
cp THEME_CREATION.md "$BUILD_DIR/$PACKAGE_DIR/usr/share/doc/siru/"

# Create wrapper script
cat > "$BUILD_DIR/$PACKAGE_DIR/usr/bin/siru" << 'EOF'
#!/bin/bash
ORIG_DIR="$PWD"
cd /usr/share/siru
CD="$ORIG_DIR" exec ruby -I lib bin/siru "$@"
EOF

# Copy the actual binary
mkdir -p "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/bin"
cp bin/siru "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/bin/"

# Set permissions
chmod +x "$BUILD_DIR/$PACKAGE_DIR/usr/bin/siru"
chmod +x "$BUILD_DIR/$PACKAGE_DIR/usr/share/siru/bin/siru"
chmod 755 "$BUILD_DIR/$PACKAGE_DIR/DEBIAN/postinst"

# Build the package
cd "$BUILD_DIR"
dpkg-deb --build "$PACKAGE_DIR"

echo "Package built: $BUILD_DIR/${PACKAGE_DIR}.deb"
