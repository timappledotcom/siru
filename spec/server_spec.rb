require 'spec_helper'
require_relative '../lib/siru/server'

RSpec.describe Siru::Server do
  let(:config_content) do
    <<~TOML
      baseURL = "http://localhost:4000/"
      title = "Test Site"
      theme = "paper"
      languageCode = "en-us"

      [params]
      color = "linen"
      bio = "A test site"
    TOML
  end

  before(:each) do
    File.write('config.toml', config_content)
    FileUtils.mkdir_p('content/posts')
  end

  after(:each) do
    FileUtils.rm_rf('content')
    File.delete('config.toml') if File.exist?('config.toml')
  end

  describe '#start' do
    it 'starts the server with given configurations' do
      config = Siru::Config.load
      site = Siru::Site.new(config)
      server = Siru::Server.new(site, port: 4321)

      allow(server).to receive(:trap)
      expect(server).to receive(:start_webrick)

      server.start

      expect(server.config.port).to eq(4321)
    end
  end
end
