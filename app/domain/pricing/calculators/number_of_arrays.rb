module Pricing
  module Calculators
    class Letters < Base
      def initialize(arrays_number_fetcher)
        super
      end

      def self.call(arrays_number_fetcher: Fetchers::ArraysNumber)
        raise ArgumentError if arrays_number_fetcher.blank?

        new(arrays_number_fetcher).call
      end

      private

      def price
        number_fetcher.call
      end
    end
  end
end
