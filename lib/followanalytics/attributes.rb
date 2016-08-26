require 'rest-client'
require 'oj'

module Followanalytics
  module Attributes
    class Client
      attr_accessor :sor_identifier

      MISSING_SOR = 'Missing System of Record identifier.'.freeze
      MISSING_API_KEY = 'Missing api key in configuration.'.freeze

      PREDEFINED_ATTRIBUTE_KEYS = %w(
        first_name last_name email date_of_birth gender country city region
        profile_picture
      ).freeze

      def initialize(sor_identifier)
        raise Followanalytics::Error, MISSING_SOR if sor_identifier.nil?
        @sor_identifier = sor_identifier
      end

      PREDEFINED_ATTRIBUTE_KEYS.each do |attribute_key|
        define_method("set_#{attribute_key}") do |value, customer_id|
          set_value(value, attribute_key, customer_id)
        end
      end

      # TODO: Attributes of type set.
      def set_value(value, key, customer_id)
        hash = attribute_hash(value, key, customer_id)
        send_attributes(hash)
      end

      # TODO: Attributes of type set.
      def unset_value(key, user_id)
        hash = attribute_hash(nil, key, customer_id)
        send_attributes(hash)
      end

      private

      def attributes_url
        "#{Followanalytics.configuration.attribute_base_url}/api/attribute_values"
      end

      def attribute_hash(value, key, customer_id)
        {
          "attribute_key"    => key,
          "attribute_value"  => value,
          "customer_id"      => customer_id,
          "customer_id_type" => "user_id"
        }
      end

      def send_attributes(hash)
        api_key = Followanalytics.configuration.api_key
        raise Followanalytics::Error, MISSING_API_KEY if api_key.nil?

        params = Oj.dump({
          "sor" => @sor_identifier,
          "api_key" => api_key,
          "customer_attribute_values" => hash
        })

        response = RestClient.post(attributes_url, params, content_type: :json)
      rescue RestClient::Exception => exception
        raise Followanalytics::Error.from_rest_client(exception)
      end
    end
  end
end
