require 'spec_helper'
require_relative '../lib/siru/post'

RSpec.describe Siru::Post do
  let(:post_file) { 'test-post.md' }
  let(:post_content) do
    <<~MARKDOWN
      +++
      title = "Test Post"
      date = "2025-07-13"
      draft = false
      tags = ["test", "example"]
      summary = "A test post"
      +++

      # Test Post

      This is a test post content.

      ## Section 2

      More content here.
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
    File.write(post_file, post_content)
  end

  after(:each) do
    [post_file, 'draft-post.md'].each do |file|
      File.delete(file) if File.exist?(file)
    end
  end

  describe '#initialize' do
    it 'loads post from file' do
      post = Siru::Post.new(post_file)

      expect(post.title).to eq('Test Post')
      expect(post.date).to be_a(DateTime)
      expect(post.date.strftime('%Y-%m-%d')).to eq('2025-07-13')
      expect(post.draft?).to be(false)
      expect(post.tags).to eq(['test', 'example'])
      expect(post.summary).to eq('A test post')
    end
    
    it 'handles datetime with time component' do
      datetime_content = <<~MARKDOWN
        +++
        title = "DateTime Test"
        date = "2025-07-13T14:30:00"
        draft = false
        +++
        
        # DateTime Test Post
        
        This post has a specific time.
      MARKDOWN
      
      File.write('datetime-test.md', datetime_content)
      post = Siru::Post.new('datetime-test.md')
      
      expect(post.date).to be_a(DateTime)
      expect(post.date.strftime('%Y-%m-%d %H:%M:%S')).to eq('2025-07-13 14:30:00')
      expect(post.date.hour).to eq(14)
      expect(post.date.minute).to eq(30)
      
      File.delete('datetime-test.md')
    end

    it 'generates slug from title' do
      post = Siru::Post.new(post_file)

      expect(post.slug).to eq('test-post')
    end

    it 'processes markdown content' do
      post = Siru::Post.new(post_file)

      expect(post.rendered_content).to include('<h1>Test Post</h1>')
      expect(post.rendered_content).to include('<h2>Section 2</h2>')
      expect(post.rendered_content).to include('<p>This is a test post content.</p>')
    end

    it 'handles draft posts' do
      File.write('draft-post.md', draft_post_content)
      post = Siru::Post.new('draft-post.md')

      expect(post.draft?).to be(true)
      expect(post.title).to eq('Draft Post')
    end
  end

  describe '#published?' do
    it 'returns true for published posts' do
      post = Siru::Post.new(post_file)

      expect(post.published?).to be(true)
    end

    it 'returns false for draft posts' do
      File.write('draft-post.md', draft_post_content)
      post = Siru::Post.new('draft-post.md')

      expect(post.published?).to be(false)
    end
  end

  describe '#excerpt' do
    it 'returns summary when available' do
      post = Siru::Post.new(post_file)

      expect(post.excerpt).to eq('A test post')
    end

    it 'generates excerpt from content when no summary' do
      content_without_summary = post_content.gsub(/summary = "A test post"/, '')
      File.write('no-summary.md', content_without_summary)
      post = Siru::Post.new('no-summary.md')

      expect(post.excerpt).to include('This is a test post content.')
      expect(post.excerpt.length).to be <= 200

      File.delete('no-summary.md')
    end
  end

  describe '#url' do
    it 'generates URL from slug' do
      post = Siru::Post.new(post_file)

      expect(post.url).to eq('/posts/test-post/')
    end

    it 'uses custom slug if provided' do
      content_with_slug = post_content.gsub(/date = "2025-07-13"/, 'date = "2025-07-13"' + "\n" + 'slug = "custom-slug"')
      File.write('custom-slug.md', content_with_slug)
      post = Siru::Post.new('custom-slug.md')

      expect(post.url).to eq('/posts/custom-slug/')

      File.delete('custom-slug.md')
    end
  end
end
