module Siru
  class Server
    def initialize(site, options = {})
      @site = site
      @options = options
      @port = options[:port] || 3000
      @watch = options[:watch] || false
      @output_dir = 'public'
    end
    
    def start
      puts "Starting Siru server on port #{@port}..."
      
      # Build the site initially
      builder = Builder.new(@site, @options)
      builder.build
      
      # Set up file watching if enabled
      setup_watcher if @watch
      
      # Start the web server
      server = WEBrick::HTTPServer.new(
        Port: @port,
        DocumentRoot: @output_dir,
        Logger: WEBrick::Log.new('/dev/null'),
        AccessLog: []
      )
      
      trap('INT') { server.shutdown }
      
      puts "Server running at http://localhost:#{@port}/"
      puts "Press Ctrl+C to stop"
      
      server.start
    end
    
    private
    
    def setup_watcher
      listener = Listen.to('.', only: /\.(md|toml|yaml|yml|liquid|html|css|js)$/) do |modified, added, removed|
        puts "Files changed: #{(modified + added + removed).join(', ')}"
        puts "Rebuilding..."
        
        # Reload site configuration and rebuild
        config = Config.load
        @site = Site.new(config)
        builder = Builder.new(@site, @options)
        builder.build
        
        puts "Rebuild complete!"
      end
      
      listener.start
    end
  end
end

