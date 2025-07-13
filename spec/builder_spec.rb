require 'spec_helper'
require_relative '../lib/siru/builder'

RSpec.describe Siru::Builder do
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

      # Test Post

      This is a test post.
    MARKDOWN
  end

  before(:each) do
    File.write('config.toml', config_content)
    FileUtils.mkdir_p('content/posts')
    File.write('content/posts/test-post.md', post_content)
    
    # Create theme structure
    FileUtils.mkdir_p('themes/paper/layouts')
    FileUtils.mkdir_p('themes/paper/static/assets')
    
    # Create basic theme templates
    File.write('themes/paper/layouts/baseof.liquid', <<~LIQUID)
      <!DOCTYPE html>
      <html>
      <head>
        <title>{{ site.title }}</title>
      </head>
      <body>
        {{ content }}
      </body>
      </html>
    LIQUID
    
    File.write('themes/paper/layouts/index.liquid', <<~LIQUID)
      <h1>{{ site.title }}</h1>
      {% for post in posts %}
        <article>
          <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
          <p>{{ post.excerpt }}</p>
        </article>
      {% endfor %}
    LIQUID
    
    File.write('themes/paper/layouts/post.liquid', <<~LIQUID)
      <article>
        <h1>{{ post.title }}</h1>
        <div>{{ post.content }}</div>
      </article>
    LIQUID
  end

  after(:each) do
    FileUtils.rm_rf(['content', 'themes', 'public'])
    File.delete('config.toml') if File.exist?('config.toml')
  end

  describe '#build' do
    it 'creates public directory' do
      config = Siru::Config.load
      site = Siru::Site.new(config)
      builder = Siru::Builder.new(site)

      builder.build

      expect(Dir).to exist('public')
    end

    it 'builds index page' do
      config = Siru::Config.load
      site = Siru::Site.new(config)
      builder = Siru::Builder.new(site)

      builder.build

      expect(File).to exist('public/index.html')
      content = File.read('public/index.html')
      expect(content).to include('Test Site')
      expect(content).to include('Test Post')
    end

    it 'builds individual post pages' do
      config = Siru::Config.load
      site = Siru::Site.new(config)
      builder = Siru::Builder.new(site)

      builder.build

      expect(File).to exist('public/posts/test-post/index.html')
      content = File.read('public/posts/test-post/index.html')
      expect(content).to include('Test Post')
    end
  end

  describe '#clean' do
    it 'removes public directory' do
      FileUtils.mkdir_p('public')
      File.write('public/test.html', 'test')

      config = Siru::Config.load
      site = Siru::Site.new(config)
      builder = Siru::Builder.new(site)

      builder.clean

      expect(Dir).not_to exist('public')
    end
  end
end
