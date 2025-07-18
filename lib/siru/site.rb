module Siru
  class Site
    attr_reader :config, :posts, :theme
    
    def initialize(config, options = {})
      @config = config
      @options = options
@theme = Theme.new(config['theme'] || 'default')
      @posts = load_posts
    end
    
    def title
      @config['title']
    end
    
    def base_url
      @config['baseURL']
    end
    
    def params
      @config['params'] || {}
    end
    
    def language_code
      @config['languageCode'] || 'en-us'
    end
    
    private
    
    def load_posts
      posts = []
      content_dir = 'content'
      
      return posts unless Dir.exist?(content_dir)
      
      Dir.glob(File.join(content_dir, '**', '*.md')).each do |file|
        post = Post.new(file)
        # Include drafts if --draft option is set
        if @options[:draft] || !post.draft?
          posts << post
        end
      end
      
      posts.sort_by(&:date).reverse
    end
  end
end
