#!/bin/bash

# Siru Local APT Repository Management Script
# This script helps manage the local siru APT repository

REPO_DIR="/home/tim/Projects/static_site_gen/siru/apt-repo"
SOURCES_FILE="/etc/apt/sources.list.d/siru-local.list"

show_help() {
    cat << EOF
Siru Local APT Repository Manager

Usage: $0 [command]

Commands:
    install     Install siru from local repository
    upgrade     Upgrade siru to latest version
    remove      Remove siru package
    status      Show current installation status
    build       Build new .deb package (requires being in siru directory)
    update-repo Update local repository after adding new .deb
    setup       Set up local APT repository source
    cleanup     Remove external repositories
    help        Show this help

Examples:
    $0 install      # Install siru
    $0 upgrade      # Upgrade to latest version
    $0 status       # Check current version
    $0 build        # Build new package from source
EOF
}

setup_repo() {
    echo "Setting up local APT repository..."
    echo "deb [trusted=yes] file://$REPO_DIR stable main" | sudo tee $SOURCES_FILE
    chmod 755 "$REPO_DIR" -R
    sudo apt update
    echo "Local repository set up successfully!"
}

install_siru() {
    echo "Installing siru from local repository..."
    sudo apt update
    sudo apt install siru
}

upgrade_siru() {
    echo "Upgrading siru..."
    sudo apt update
    sudo apt upgrade siru
}

remove_siru() {
    echo "Removing siru..."
    sudo apt remove siru
}

show_status() {
    echo "=== Siru Installation Status ==="
    apt policy siru
    echo ""
    echo "=== Available versions ==="
    apt list siru -a
    echo ""
    echo "=== Local repository contents ==="
    ls -la $REPO_DIR/pool/main/s/siru/
}

build_package() {
    if [ ! -f "./packaging/build-deb.sh" ]; then
        echo "Error: Must be run from siru source directory"
        exit 1
    fi
    
    echo "Building new .deb package..."
    ./packaging/build-deb.sh
    
    echo "Copying to local repository..."
    VERSION=$(grep 'VERSION = ' lib/siru.rb | sed 's/.*"\(.*\)".*/\1/')
    cp "packaging/build/siru_${VERSION}_all.deb" "$REPO_DIR/pool/main/s/siru/"
    
    echo "Updating repository..."
    cd "$REPO_DIR"
    ./update-repo.sh
    
    echo "Package built and repository updated!"
}

update_repo() {
    echo "Updating local repository..."
    cd "$REPO_DIR"
    ./update-repo.sh
    sudo apt update
    echo "Repository updated!"
}

cleanup_external() {
    echo "Cleaning up external repositories..."
    sudo find /etc/apt/sources.list.d -name "*.list" -exec grep -l "timappledotcom" {} \; -delete 2>/dev/null || true
    sudo apt clean
    sudo apt update
    echo "External repositories cleaned up!"
}

case "$1" in
    install)
        install_siru
        ;;
    upgrade)
        upgrade_siru
        ;;
    remove)
        remove_siru
        ;;
    status)
        show_status
        ;;
    build)
        build_package
        ;;
    update-repo)
        update_repo
        ;;
    setup)
        setup_repo
        ;;
    cleanup)
        cleanup_external
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
