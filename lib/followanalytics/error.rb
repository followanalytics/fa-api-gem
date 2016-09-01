require 'oj'

module Followanalytics
  class Error < StandardError
    attr_accessor :original_exception

    def initialize(message, original_exception = nil)
      super(message)
      @original_exception = original_exception
    end

    def self.from_rest_client(exception)
      body = Oj.load(exception.response.body)
      self.new(body['message'], exception)
    end
  end
end
