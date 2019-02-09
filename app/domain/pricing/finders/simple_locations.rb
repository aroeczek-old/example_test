module Pricing
  module Finders
    class SimpleLocations
      def initialize(params)
        @params = params
        @code   =  params.dig(:country_code)
      end

      def self.call(params)
        new(params).call
      end

      def call
        #probably in reall system search will be more complex and her will be tak care abou pagination
        code.blank? ? Location.all : Location.by_country_code(code)
      end

      private

      attr_reader :params, :code
    end
  end
end
