module Pricing
  module Finders
    class SimpleLocations
      def initialize(code)
        @code = code
      end

      def self.call(code = nil)
        new(code).call
      end

      def call
        #probably in reall system search will be more complex and her will be tak care abou pagination
        code.blank? ? Location.all : Location.by_country_code(code)
      end

      private

      attr_reader :code
    end
  end
end
