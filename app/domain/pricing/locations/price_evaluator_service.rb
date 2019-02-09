module Pricing
  module Locations
    class PriceEvaluatorService
      # If the project would be more advanced I would use Value object for location price
      # which additionaly should contains currency etc.
      Price = Struct.new(:location_id, :price)

      def initialize(location_ids, country_code, response_modifier)
        raise ArgumentError if country_code.blank?

        @locations         = Location.find(location_ids)
        @country_code      = country_code
        @response_modifier = response_modifier
      end

      def self.call(location_ids:, country_code:, &response_modifier)
        new(location_ids, country_code, response_modifier).call
      end

      def call
        evaluate
      end

      private

      attr_reader :locations, :country_code, :response_modifier

      def evaluate
        locations.map do |location|
          price = Price.new(location.id, location.price_for_country_code(country_code))

          response_modifier&.call(price) || price
        end
      end
    end
  end
end
