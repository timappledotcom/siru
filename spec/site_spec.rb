require 'spec_helper'
require_relative '../lib/siru/site'
require_relative '../lib/siru/config'

RSpec.describe Siru::Site do
  let(:config_content) do
    <<~TOML
      baseURL = "https://example.com"
      title = "Test Site"
      theme = "paper"
      languageCode = "en-us"

      [params]
      color = "linen"
      bio = "A test site"
    TOML
  end

  let(:post_content) do
    <<~MARKDOWN
      +++
      title = "Test Post"
      date = "2025-07-13"
      draft = false
      +++

      This is a test post.
    MARKDOWN
  end

  let(:draft_post_content) do
    <<~MARKDOWN
      +++
      title = "Draft Post"
      date = "2025-07-13"
      draft = true
      +++

      This is a draft post.
    MARKDOWN
  end

  before(:each) do
    File.write('config.toml', config_content)
    FileUtils.mkdir_p('content/posts')
    File.write('content/posts/test-post.md', post_content)
    File.write('content/posts/draft-post.md', draft_post_content)
  end

  after(:each) do
    FileUtils.rm_rf('content')
    File.delete('config.toml') if File.exist?('config.toml')
  end

  describe '#initialize' do
    it 'loads configuration and posts' do
      config = Siru::Config.load
      site = Siru::Site.new(config)

      expect(site.config.title).to eq('Test Site')
      expect(site.posts.length).to eq(1) # Only published posts by default
      expect(site.posts.first.title).to eq('Test Post')
    end

    it 'includes draft posts when draft option is true' do
      config = Siru::Config.load
      site = Siru::Site.new(config, draft: true)

      expect(site.posts.length).to eq(2)
      titles = site.posts.map(&:title)
      expect(titles).to include('Test Post', 'Draft Post')
    end
  end

  describe '#published_posts' do
    it 'returns only published posts' do
      config = Siru::Config.load
      site = Siru::Site.new(config, draft: true)

      published = site.published_posts
      expect(published.length).to eq(1)
      expect(published.first.title).to eq('Test Post')
    end
  end

  describe '#draft_posts' do
    it 'returns only draft posts' do
      config = Siru::Config.load
      site = Siru::Site.new(config, draft: true)

      drafts = site.draft_posts
      expect(drafts.length).to eq(1)
      expect(drafts.first.title).to eq('Draft Post')
    end
  end

  describe '#load_posts' do
    it 'loads posts from content/posts directory' do
      config = Siru::Config.load
      site = Siru::Site.new(config, draft: true)

      expect(site.posts.length).to eq(2)
      expect(site.posts.map(&:title)).to include('Test Post', 'Draft Post')
    end

    it 'handles missing content directory gracefully' do
      FileUtils.rm_rf('content')
      config = Siru::Config.load
      site = Siru::Site.new(config)

      expect(site.posts).to be_empty
    end
  end

  describe '#recent_posts' do
    it 'returns posts in reverse chronological order' do
      # Create posts with different dates
      newer_post = post_content.gsub('2025-07-13', '2025-07-14')
      File.write('content/posts/newer-post.md', newer_post.gsub('Test Post', 'Newer Post'))

      config = Siru::Config.load
      site = Siru::Site.new(config)

      recent = site.recent_posts
      expect(recent.first.title).to eq('Newer Post')
      expect(recent.last.title).to eq('Test Post')
    end

    it 'limits the number of posts returned' do
      # Create multiple posts
      3.times do |i|
        content = post_content.gsub('Test Post', "Post #{i}").gsub('2025-07-13', "2025-07-#{14 + i}")
        File.write("content/posts/post-#{i}.md", content)
      end

      config = Siru::Config.load
      site = Siru::Site.new(config)

      recent = site.recent_posts(2)
      expect(recent.length).to eq(2)
    end
  end
end
