module Siru
  class Config
    attr_reader :data
    
    def self.load(path = 'config.toml')
      new(path)
    end
    
    def initialize(path = 'config.toml')
      @path = path
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
    
    private
    
    def load_config
      return default_config unless File.exist?(@path)
      
      case File.extname(@path)
      when '.toml'
        TOML.load_file(@path)
      when '.yaml', '.yml'
        YAML.load_file(@path)
      else
        raise "Unsupported config format: #{@path}"
      end
    rescue => e
      puts "Error loading config: #{e.message}"
      default_config
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
