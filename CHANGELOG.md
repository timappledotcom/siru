# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- Unified default theme system with 7 color schemes and 10 fonts
- Dynamic theme and font switching in browser with localStorage persistence
- Support for Catppuccin (4 variants), Nord, Dracula, and Tokyo Night color schemes
- Enhanced social media integration (Twitter, GitHub, Mastodon, Bluesky, Nostr, RSS)
- Comprehensive theme configuration examples and documentation
- Mobile-first responsive design with semantic HTML
- CSS custom properties for easy theming
- Runtime theme switching JavaScript

### Changed
- Consolidated all themes into single 'default' theme
- Updated documentation with table of contents and streamlined content
- Improved configuration examples with popular theme/font combinations
- Enhanced README with comprehensive setup and usage guide

### Removed
- Separate 'paper' and 'paper+' themes (replaced by unified system)
- Outdated theme-specific documentation

## [0.2.3] - 2025-07-13

### Fixed
- Fixed critical bug where `siru build` and `siru serve` commands were not working from site directories
- Both commands now properly change to the site directory before executing
- Added proper error handling when commands are run outside of a Siru site directory

## [0.2.2] - Previous Release

### Added
- Initial stable release with basic functionality
- Support for Liquid templates
- Markdown processing with front matter
- Theme support
- Live reloading development server
- Basic theme included
