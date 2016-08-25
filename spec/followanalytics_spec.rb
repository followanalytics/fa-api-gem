require "spec_helper"

describe Followanalytics do
  it "has a version number" do
    expect(Followanalytics::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'uses the default API url if none is given' do
      expect(Followanalytics.configuration.api_base_url).
        to eq(Followanalytics::Configuration::DEFAULT_API_BASE_URL)
    end

    it 'uses the given API url if given' do
      base_url = Faker::Internet.url
      Followanalytics.configure do |config|
        config.api_base_url = base_url
      end

      expect(Followanalytics.configuration.api_base_url).to eq(base_url)
    end
  end
end
