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
          'params' => {
            'theme' => 'catppuccin-mocha',
            'font' => 'inter',
            'bio' => 'A blog powered by Siru'
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
        
        # Copy default theme files
        siru_gem_dir = File.expand_path('../../..', __FILE__)
        source_theme_dir = File.join(siru_gem_dir, 'themes', 'default')
        target_theme_dir = File.join('themes', 'default')
        
        if Dir.exist?(source_theme_dir)
          FileUtils.cp_r(source_theme_dir, 'themes/')
          puts "Theme 'default' copied successfully"
        else
          puts "Warning: Theme 'default' not found in #{source_theme_dir}"
        end
        
        puts "Site created successfully!"
        puts "To get started:"
        puts "  cd #{name}"
        puts "  siru serve"
      end
    end
    
    def self.build(options = {})
      # Get the original working directory from environment variable or current directory
      original_dir = ENV['CD'] || Dir.pwd
      config_path = File.join(original_dir, 'config.toml')
      
      unless File.exist?(config_path)
        puts "Error: Not in a Siru site directory. Run 'siru new SITENAME' first."
        exit 1
      end
      
      Dir.chdir(original_dir) do
        config = Config.load
        site = Site.new(config, options)
        builder = Builder.new(site, options)
        builder.build
      end
    end
    
    def self.serve(options = {})
      # Get the original working directory from environment variable or current directory
      original_dir = ENV['CD'] || Dir.pwd
      config_path = File.join(original_dir, 'config.toml')
      
      unless File.exist?(config_path)
        puts "Error: Not in a Siru site directory. Run 'siru new SITENAME' first."
        exit 1
      end
      
      Dir.chdir(original_dir) do
        config = Config.load
        site = Site.new(config, options)
        server = Server.new(site, options)
        server.start
      end
    end
    
    def self.new_post(title, options = {})
      # Get the original working directory from environment variable or current directory
      original_dir = ENV['CD'] || Dir.pwd
      config_path = File.join(original_dir, 'config.toml')
      
      unless File.exist?(config_path)
        puts "Error: Not in a Siru site directory. Run 'siru new SITENAME' first."
        exit 1
      end
      
      # Generate filename from title
      filename = title.downcase.gsub(/\s+/, '-').gsub(/[^a-z0-9\-]/, '') + '.md'
      filepath = File.join(original_dir, 'content', 'posts', filename)
      
      # Check if file already exists
      if File.exist?(filepath)
        puts "Error: Post '#{filepath}' already exists."
        exit 1
      end
      
      # Create the posts directory if it doesn't exist
      FileUtils.mkdir_p(File.dirname(filepath))
      
      # Generate post content
      date = Date.today.strftime('%Y-%m-%d')
      draft = options[:draft] ? 'true' : 'false'
      
      # Clean up the title (remove any surrounding quotes)
      clean_title = title.gsub(/^["']|["']$/, '')
      
      post_content = <<~POST
        +++
        title = "#{clean_title}"
        date = "#{date}"
        draft = #{draft}
        +++
        
        Write your post content here.
      POST
      
      # Write the file
      File.write(filepath, post_content)
      puts "Created new post: #{filepath}"
      
      # Open in editor
      editor = ENV['EDITOR'] || ENV['VISUAL'] || 'nano'
      system("#{editor} #{filepath}")
    end
  end
end
