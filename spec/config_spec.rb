require 'spec_helper'
require_relative '../lib/siru/config'

RSpec.describe Siru::Config do
  let(:config_file) { 'config.toml' }
  let(:sample_config) do
    <<~TOML
      baseURL = "https://example.com"
      title = "My Blog"
      theme = "paper"
      languageCode = "en-us"

      [params]
      color = "linen"
      bio = "A test blog"
    TOML
  end

  before(:each) do
    File.write(config_file, sample_config)
  end

  after(:each) do
    File.delete(config_file) if File.exist?(config_file)
  end

  describe '.load' do
    it 'loads configuration from config.toml' do
      config = Siru::Config.load

      expect(config.baseURL).to eq('https://example.com')
      expect(config.title).to eq('My Blog')
      expect(config.theme).to eq('paper')
      expect(config.languageCode).to eq('en-us')
    end

    it 'loads parameters section' do
      config = Siru::Config.load

      expect(config.params['color']).to eq('linen')
      expect(config.params['bio']).to eq('A test blog')
    end

    it 'raises error when config file is missing in strict mode' do
      File.delete(config_file)
      
      expect { Siru::Config.load(config_file, strict: true) }.to raise_error(Siru::Config::ConfigError)
    end
    
    it 'uses default config when config file is missing in non-strict mode' do
      File.delete(config_file)
      
      config = Siru::Config.load(config_file, strict: false)
      expect(config.title).to eq('My Siru Site')
      expect(config.theme).to eq('paper')
    end
  end

  describe '#get' do
    it 'retrieves configuration values' do
      config = Siru::Config.load

      expect(config.get('baseURL')).to eq('https://example.com')
      expect(config.get('title')).to eq('My Blog')
      expect(config.get('nonexistent')).to be_nil
    end
  end

  describe '#param' do
    it 'retrieves parameter values' do
      config = Siru::Config.load

      expect(config.param('color')).to eq('linen')
      expect(config.param('bio')).to eq('A test blog')
      expect(config.param('nonexistent')).to be_nil
    end
  end
end
