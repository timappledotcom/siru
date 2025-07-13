Gem::Specification.new do |spec|
  spec.name = "siru"
  spec.version = "0.4.0"
  spec.authors       = ["Tim Apple"]
  spec.email         = ["tim.apple@hey.com"]
  spec.summary       = "A Hugo-inspired static site generator built in Ruby"
  spec.description   = "Siru is a fast, flexible static site generator inspired by Hugo, built in Ruby with support for themes, markdown processing, and live reloading."
  spec.homepage      = "https://github.com/timappledotcom/siru"
  spec.license       = "GPL-3.0"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files = Dir.glob("{lib,bin,themes,templates}/**/*") + %w[README.md Gemfile siru.gemspec]
  spec.bindir        = "bin"
  spec.executables   = ["siru"]
  spec.require_paths = ["lib"]

  spec.add_dependency "redcarpet", "~> 3.6"
  spec.add_dependency "liquid", "~> 5.4"
  spec.add_dependency "toml", "~> 0.3"
  spec.add_dependency "sassc", "~> 2.4"
  spec.add_dependency "listen", "~> 3.8"
  spec.add_dependency "webrick", "~> 1.8"
  spec.add_dependency "front_matter_parser", "~> 1.0"
  spec.add_dependency "base64"
  spec.add_dependency "logger"
  spec.add_dependency "parslet"

  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.56"
end
