require 'spec_helper'
require_relative '../lib/siru/cli'

RSpec.describe Siru::CLI do
  before(:each) do
    @original_dir = Dir.pwd
    @site_name = 'test_site'
    @site_path = File.join(@original_dir, @site_name)
    FileUtils.mkdir_p(@site_path)
    Dir.chdir(@site_path) do
      File.write('config.toml', 'baseURL = "http://localhost:3000/"')
      FileUtils.mkdir_p('content/posts')
    end
  end

  after(:each) do
    FileUtils.rm_rf(@site_path)
  end

  describe '#new_post' do
    it 'creates a new post file with the correct front matter' do
      post_title = 'My New Post'
      expected_path = File.join(@site_path, 'content', 'posts', 'my-new-post.md')

      Siru::CLI.new_post(post_title)

      expect(File).to exist(expected_path)

      content = File.read(expected_path)
      expect(content).to include('title = "My New Post"')
      expect(content).to match(/date = "\d{4}-\d{2}-\d{2}"/)
    end
  end

  describe '#new_site' do
    it 'creates the directory structure for a new site' do
      Siru::CLI.new_site('new_site_test')

      expected_dirs = %w[content content/posts static themes public]
      expected_dirs.each do |dir|
        expect(Dir).to exist(File.join('new_site_test', dir))
      end

      expected_config = 'new_site_test/config.toml'
      expect(File).to exist(expected_config)
      expect(File.read(expected_config)).to include('baseURL = "http://localhost:3000/"')
    end
  end
end

