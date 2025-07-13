require 'bundler/setup'
require 'fileutils'
require 'tmpdir'
require_relative '../lib/siru'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Create a temporary directory for each test
  config.around(:each) do |example|
    Dir.mktmpdir do |tmpdir|
      original_dir = Dir.pwd
      Dir.chdir(tmpdir)
      
      begin
        example.run
      ensure
        Dir.chdir(original_dir)
      end
    end
  end
end
