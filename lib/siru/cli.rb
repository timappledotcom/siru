module Siru
  class CLI
    def self.new_site(name)
      puts "Creating new site: #{name}"
      
      # Get the original working directory from environment variable or current directory
      original_dir = ENV['CD'] || Dir.pwd
      target_dir = File.expand_path(name, original_dir)
      
      FileUtils.mkdir_p(target_dir)
      Dir.chdir(target_dir) do
        # Create directory structure
        %w[content content/posts static themes public].each do |dir|
          FileUtils.mkdir_p(dir)
        end
        
        # Create config file
        config = {
          'baseURL' => 'http://localhost:3000/',
          'languageCode' => 'en-us',
          'title' => name.capitalize,
          'theme' => 'paper',
          'params' => {
            'color' => 'linen',
            'bio' => 'A blog powered by Siru',
            'disableHLJS' => true,
            'disablePostNavigation' => true,
            'monoDarkIcon' => true,
            'math' => true,
            'localKatex' => false
          }
        }
        
        File.write('config.toml', TOML::Generator.new(config).body)
        
        # Create sample post
        sample_post = <<~POST
          +++
          title = "Hello Siru"
          date = "#{Date.today.strftime('%Y-%m-%d')}"
          draft = false
          +++
          
          Welcome to your new Siru site!
          
          This is your first post. Edit or delete it and start blogging!
        POST
        
        File.write('content/posts/hello-siru.md', sample_post)
        
        puts "Site created successfully!"
        puts "To get started:"
        puts "  cd #{name}"
        puts "  siru serve"
      end
    end
    
    def self.build(options = {})
      config = Config.load
      site = Site.new(config, options)
      builder = Builder.new(site, options)
      builder.build
    end
    
    def self.serve(options = {})
      config = Config.load
      site = Site.new(config, options)
      server = Server.new(site, options)
      server.start
    end
  end
end
