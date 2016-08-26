require 'oj'

module Followanalytics
  class Error < StandardError
    def self.from_rest_client(exception)
      body = Oj.load(exception.response.body)
      self.new(body['message'])
    end
  end
end
