module Pricing
  module Calculators
    class Base
      def initialize(number_fetcher)
        @number_fetcher = number_fetcher
      end

      def call
        price
      end

      protected

      attr_accessor :number_fetcher

      def price
        raise NotImplementedError
      end
    end
  end
end
