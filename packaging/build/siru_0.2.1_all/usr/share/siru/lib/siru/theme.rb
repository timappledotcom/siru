module Siru
  class Theme
    attr_reader :name, :path
    
    def initialize(name)
      @name = name
      @path = find_theme_path(name)
    end
    
    def layout_path(layout_name)
      if File.exist?(File.join(@path, 'layouts', "#{layout_name}.liquid"))
        File.join(@path, 'layouts', "#{layout_name}.liquid")
      else
        # Fall back to built-in theme
        builtin_path = File.join(__dir__, '..', '..', 'themes', @name, 'layouts', "#{layout_name}.liquid")
        File.exist?(builtin_path) ? builtin_path : nil
      end
    end
    
    def has_layout?(layout_name)
      !layout_path(layout_name).nil?
    end
    
    def render_layout(layout_name, variables = {})
      path = layout_path(layout_name)
      return '' unless path
      
      template = Liquid::Template.parse(File.read(path))
      template.render(variables)
    end
    
    def static_files
      static_path = File.join(@path, 'static')
      return [] unless Dir.exist?(static_path)
      
      Dir.glob(File.join(static_path, '**', '*')).select { |f| File.file?(f) }
    end
    
    private
    
    def find_theme_path(name)
      # Check local themes directory first
      local_path = File.join('themes', name)
      return File.expand_path(local_path) if Dir.exist?(local_path)
      
      # Fall back to built-in theme
      builtin_path = File.join(__dir__, '..', '..', 'themes', name)
      return File.expand_path(builtin_path) if Dir.exist?(builtin_path)
      
      # Create basic theme structure if not found
      FileUtils.mkdir_p(File.join('themes', name, 'layouts'))
      FileUtils.mkdir_p(File.join('themes', name, 'static'))
      File.expand_path(File.join('themes', name))
    end
  end
end
