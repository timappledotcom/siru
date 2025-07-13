# Siru v0.2.2 - Bug Fixes and Improvements

## 🐛 Bug Fixes

### Theme Files Missing in New Sites
- **Fixed**: `siru new` now automatically copies theme files to the new site directory
- **Issue**: Previously, new sites created with `siru new` didn't have theme files, causing `siru build` to fail
- **Solution**: The CLI now copies the paper theme from the main siru installation to the new site's `themes/` directory

### Test Suite Improvements
- **Fixed**: Added missing dependencies (`base64`, `logger`, `parslet`) to resolve Ruby 3.4+ compatibility warnings
- **Fixed**: Updated Config class to properly handle TOML parsing errors with `Parslet::ParseFailed`
- **Fixed**: Added `clean` method to Builder class for proper cleanup functionality
- **Fixed**: All tests now pass successfully

### Configuration Enhancements
- **Added**: `ConfigError` exception class for better error handling
- **Added**: Support for both strict and non-strict config loading modes
- **Added**: Dynamic attribute access for config values (e.g., `config.title`)
- **Added**: `get()` and `param()` methods for accessing config values

## 🔧 Technical Improvements

- Updated all version references to 0.2.2
- Improved error handling for missing theme files
- Enhanced test coverage for core functionality
- Better Ruby 3.4+ compatibility

## 📦 Installation

### RubyGems
```bash
gem install siru
```

### Debian/Ubuntu
```bash
wget https://github.com/timappledotcom/siru/releases/download/v0.2.2/siru_0.2.2_all.deb
sudo dpkg -i siru_0.2.2_all.deb
```

### From Source
```bash
git clone https://github.com/timappledotcom/siru.git
cd siru
bundle install
gem build siru.gemspec
gem install siru-0.2.2.gem
```

## 🚀 Usage

Create a new site:
```bash
siru new my-site
cd my-site
```

Build your site:
```bash
siru build
```

Start development server:
```bash
siru serve
```

Create a new post:
```bash
siru new post "My New Post"
```

This release ensures that `siru new` creates fully functional sites that can be built immediately without any additional setup steps.
