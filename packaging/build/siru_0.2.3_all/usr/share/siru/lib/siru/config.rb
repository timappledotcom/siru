module Siru
  class Config
    class ConfigError < StandardError; end
    
    attr_reader :data
    
    def self.load(path = 'config.toml', strict: false)
      new(path, strict: strict)
    end
    
    def initialize(path = 'config.toml', strict: false)
      @path = path
      @strict = strict
      @data = load_config
    end
    
    def [](key)
      @data[key]
    end
    
    def []=(key, value)
      @data[key] = value
    end
    
    def fetch(key, default = nil)
      @data.fetch(key, default)
    end
    
    def get(key)
      @data[key]
    end
    
    def param(key)
      return nil unless @data['params']
      @data['params'][key]
    end
    
    def params
      @data['params'] || {}
    end
    
    # Dynamic attribute access for config keys
    def method_missing(method_name, *args, &block)
      if args.empty? && @data.key?(method_name.to_s)
        @data[method_name.to_s]
      else
        super
      end
    end
    
    def respond_to_missing?(method_name, include_private = false)
      @data.key?(method_name.to_s) || super
    end
    
    private
    
    def load_config
      unless File.exist?(@path)
        if @strict
          raise ConfigError, "Configuration file #{@path} not found"
        else
          return default_config
        end
      end
      
      case File.extname(@path)
      when '.toml'
        TOML.load_file(@path)
      when '.yaml', '.yml'
        YAML.load_file(@path)
      else
        raise ConfigError, "Unsupported config format: #{@path}"
      end
    rescue Parslet::ParseFailed => e
      raise ConfigError, "Error parsing TOML config: #{e.message}"
    rescue Psych::SyntaxError => e
      raise ConfigError, "Error parsing YAML config: #{e.message}"
    end
    
    def default_config
      {
        'baseURL' => 'http://localhost:3000/',
        'languageCode' => 'en-us',
        'title' => 'My Siru Site',
        'theme' => 'paper',
        'params' => {
          'color' => 'linen'
        }
      }
    end
  end
end
