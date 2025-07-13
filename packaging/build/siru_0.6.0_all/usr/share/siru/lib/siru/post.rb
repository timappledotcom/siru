module Siru
  class Post
    attr_reader :file_path, :front_matter, :content, :rendered_content
    
    def initialize(file_path)
      @file_path = file_path
      parse_file
    end
    
    def title
      @front_matter['title'] || File.basename(@file_path, '.md').tr('-', ' ').capitalize
    end
    
    def date
      date_str = @front_matter['date']
      return DateTime.now unless date_str
      
      if date_str.is_a?(String)
        DateTime.parse(date_str)
      else
        date_str
      end
    end
    
    def draft?
      @front_matter['draft'] == true
    end
    
    def slug
      @front_matter['slug'] || File.basename(@file_path, '.md')
    end
    
    def url
      "/posts/#{slug}/"
    end
    
    def summary
      @front_matter['summary'] || ''
    end
    
    def tags
      @front_matter['tags'] || []
    end
    
    def published?
      !draft?
    end
    
    def excerpt
      return summary unless summary.empty?
      
      # Generate excerpt from content if no summary available
      # Remove headers and get the first paragraph of actual content
      lines = @content.split("\n")
      content_lines = lines.reject { |line| line.strip.start_with?('#') || line.strip.empty? }
      first_paragraph = content_lines.first || ''
      
      # Limit to 200 characters
      if first_paragraph.length > 200
        first_paragraph[0...197] + '...'
      else
        first_paragraph
      end
    end
    
    private
    
    def parse_file
      raw_content = File.read(@file_path)
      
      if raw_content.start_with?('+++')
        # TOML front matter
        parts = raw_content.split('+++', 3)
        @front_matter = TOML.load(parts[1]) if parts[1]
        @content = parts[2]&.strip || ''
      elsif raw_content.start_with?('---')
        # YAML front matter
        parsed = FrontMatterParser.parse(raw_content)
        @front_matter = parsed.front_matter
        @content = parsed.content
      else
        @front_matter = {}
        @content = raw_content
      end
      
      @front_matter ||= {}
      @rendered_content = render_markdown(@content)
    end
    
    def render_markdown(content)
      renderer = Redcarpet::Render::HTML.new(
        filter_html: false,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        autolink: true,
        strikethrough: true,
        superscript: true,
        tables: true
      )
      
      markdown = Redcarpet::Markdown.new(renderer, {
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        strikethrough: true,
        superscript: true,
        no_intra_emphasis: true
      })
      
      markdown.render(content)
    end
  end
end
