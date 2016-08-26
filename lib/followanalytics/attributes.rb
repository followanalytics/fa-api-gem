module Followanalytics
  module Attributes
    class Client

      PREDEFINED_ATTRIBUTE_KEYS = %w(
        first_name last_name email date_of_birth gender country city region
        profile_picture
      )

      attr_accessor :sor_identifier

      def initialize(sor_identifier)
        @sor_identifier = sor_identifier
      end

      PREDEFINED_ATTRIBUTE_KEYS.each do |attribute_key|
        define_method("set_#{attribute_key}") do |value, customer_id|
          set_value(value, attribute_key, customer_id)
        end
      end

      # TODO: Send request to the Attributes service.
      # TODO: Cache the attributes at first, and send them after a time.
      def set_value(value, key, customer_id)
      end

      # TODO: Send request to the Attributes service.
      def unset_value(key, user_id)
      end

      private

      def attributes_url
        "#{Followanalytics.configuration.attribute_base_url}/api/attribute_values"
      end
    end
  end
end
