require "followanalytics/version"

module Followanalytics
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key
    attr_accessor :api_base_url

    DEFAULT_API_BASE_URL = 'https://api.follow-apps.com'

    def initialize
      @api_base_url = DEFAULT_API_BASE_URL
    end
  end
end
