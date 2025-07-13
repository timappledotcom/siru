# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.3] - 2025-07-13

### Fixed
- Fixed critical bug where `siru build` and `siru serve` commands were not working from site directories
- Both commands now properly change to the site directory before executing, consistent with `siru new post` behavior
- Added proper error handling when commands are run outside of a Siru site directory

## [0.2.2] - Previous Release

### Features
- Initial stable release with basic functionality
- Support for Liquid templates
- Markdown processing with front matter
- Theme support
- Live reloading development server
- Paper theme included
