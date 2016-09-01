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

      # Initializes the Attributes client.
      #
      # @param sor_identifier [String] The System of Record we wish to set
      #   attributes to.
      # @raise [Followanalytics::Error] When the System of Record is not
      #   defined.
      def initialize(sor_identifier)
        raise Followanalytics::Error, MISSING_SOR if sor_identifier.nil?
        @sor_identifier = sor_identifier
      end

      PREDEFINED_ATTRIBUTE_KEYS.each do |attribute_key|
        # TODO: Find a way to document these.
        define_method("set_#{attribute_key}") do |value, customer_id|
          set_value(value, attribute_key, customer_id)
        end
      end

      # Set one value for a customer.
      #
      # @param value The value to set.
      # @param key The key of the attribute.
      # @param customer_id The customer we want to set the attribute to.
      #
      # @example Set the value "apple" to the attribute with the key "favorite_fruit" for the customer "tim"
      #   client.set_value("apple", "favorite_fruit", "tim")
      def set_value(value, key, customer_id)
        hash = attribute_hash(value, key, customer_id)
        send_attributes(hash)
      end

      # Unset one value for a customer.
      #
      # @param key The key of the attribute.
      # @param customer_id The customer we want to unset the attribute to.
      #
      # @example Unset the value "apple" to the attribute with the key "favorite_fruit" for the customer "tim"
      #   client.unset_value("favorite_fruit", "tim")
      def unset_value(key, customer_id)
        hash = attribute_hash(nil, key, customer_id)
        send_attributes(hash)
      end

      # Add a value to an attribute of type set.
      #
      # @param value The value to add to the set.
      # @param key The key of the set attribute.
      # @param customer_id The customer we want to unset the attribute to.
      #
      # @example Add the value "strawberry" to the set attribute with the key "fruit_salad" for the customer "tim"
      #   client.add_set_value("strawberry", "fruit_salad", "tim")
      def add_set_value(value, key, customer_id)
        hash = attribute_hash(value, key, customer_id).tap do |hsh|
          hsh['action_type'] = 'ADD'
        end
        send_attributes(hash)
      end

      # Remove a value to an attribute of type set.
      #
      # @param value The value to add to the set.
      # @param key The key of the set attribute.
      # @param customer_id The customer we want to unset the attribute to.
      #
      # @example Remove the value "strawberry" to the set attribute with the key "fruit_salad" for the customer "tim"
      #   client.remove_set_value("strawberry", "fruit_salad", "tim")
      def remove_set_value(value, key, customer_id)
        hash = attribute_hash(value, key, customer_id).tap do |hsh|
          hsh['action_type'] = 'REMOVE'
        end
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
          "customer_attribute_values" => [hash]
        })

        response = RestClient.post(attributes_url, params, content_type: :json)
      rescue RestClient::Exception => exception
        raise Followanalytics::Error.from_rest_client(exception)
      end
    end
  end
end
