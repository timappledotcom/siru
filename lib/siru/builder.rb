module Siru
  class Builder
    def initialize(site, options = {})
      @site = site
      @options = options
      @output_dir = 'public'
    end
    
    def build
      puts "Building site..."
      
      # Clean output directory
      FileUtils.rm_rf(@output_dir)
      FileUtils.mkdir_p(@output_dir)
      
      # Copy static files
      copy_static_files
      
      # Build pages
      build_home_page
      build_post_pages
      
      # Generate RSS feed
      generate_rss_feed
      
      puts "Site built successfully in #{@output_dir}/"
    end

    def generate_rss_feed
      rss_content = "<?xml version='1.0' encoding='UTF-8' ?>\n"
      rss_content += "<rss version='2.0'>\n"
      rss_content += "<channel>\n"
      rss_content += "<title>#{escape_xml(@site.title)}</title>\n"
      rss_content += "<link>#{@site.base_url}</link>\n"
      rss_content += "<description>The latest updates from #{escape_xml(@site.title)}</description>\n"
      
      @site.posts.each do |post|
        rss_content += "<item>\n"
        rss_content += "<title>#{escape_xml(post.title)}</title>\n"
        rss_content += "<link>#{@site.base_url.chomp('/')}#{post.url}</link>\n"
        rss_content += "<description>#{escape_xml(post.summary)}</description>\n"
        rss_content += "<pubDate>#{post.date.rfc2822}</pubDate>\n"
        rss_content += "</item>\n"
      end
      
      rss_content += "</channel>\n"
      rss_content += "</rss>\n"
      
      File.write(File.join(@output_dir, 'rss.xml'), rss_content)
    end

    def escape_xml(text)
      text.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('"', '&quot;').gsub("'", '&apos;')
    end
    
    def clean
      FileUtils.rm_rf(@output_dir)
      puts "Cleaned output directory: #{@output_dir}"
    end
    
    private
    
    def copy_static_files
      # Copy theme static files
      @site.theme.static_files.each do |file|
        relative_path = file.gsub(@site.theme.path + '/static/', '')
        output_path = File.join(@output_dir, relative_path)
        
        FileUtils.mkdir_p(File.dirname(output_path))
        FileUtils.cp(file, output_path)
      end
      
      # Copy site static files
      static_dir = 'static'
      if Dir.exist?(static_dir)
        Dir.glob(File.join(static_dir, '**', '*')).each do |file|
          next unless File.file?(file)
          
          relative_path = file.gsub(static_dir + '/', '')
          output_path = File.join(@output_dir, relative_path)
          
          FileUtils.mkdir_p(File.dirname(output_path))
          FileUtils.cp(file, output_path)
        end
      end
    end
    
    def build_home_page
      variables = {
        'site' => site_variables,
        'posts' => @site.posts.map { |post| post_variables(post) },
        'page_title' => 'Home',
        'bg_color' => color_for_theme
      }
      
      content = @site.theme.render_layout('index', variables)
      html = @site.theme.render_layout('baseof', variables.merge('content' => content))
      
      File.write(File.join(@output_dir, 'index.html'), html)
    end
    
    def build_post_pages
      @site.posts.each do |post|
        variables = {
          'site' => site_variables,
          'post' => post_variables(post),
          'page_title' => post.title,
          'bg_color' => color_for_theme
        }
        
        content = @site.theme.render_layout('single', variables)
        html = @site.theme.render_layout('baseof', variables.merge('content' => content))
        
        # Create directory structure
        post_dir = File.join(@output_dir, 'posts', post.slug)
        FileUtils.mkdir_p(post_dir)
        
        File.write(File.join(post_dir, 'index.html'), html)
      end
    end
    
    def site_variables
      {
        'title' => @site.title,
        'base_url' => @site.base_url,
        'language_code' => @site.language_code,
        'params' => @site.params
      }
    end
    
    def post_variables(post)
      {
        'title' => post.title,
        'date' => post.date,
        'slug' => post.slug,
        'url' => post.url,
        'summary' => post.summary,
        'tags' => post.tags,
        'rendered_content' => post.rendered_content,
        'content' => post.content
      }
    end
    
    def color_for_theme
      color_map = {
        'linen' => '#faf8f1',
        'wheat' => '#f8f5d7',
        'gray' => '#fbfbfb',
        'light' => '#fff',
        'catppuccin-mocha' => '#1e1e2e'
      }
      
      color_map[@site.params['color']] || color_map['linen']
    end
  end
end
