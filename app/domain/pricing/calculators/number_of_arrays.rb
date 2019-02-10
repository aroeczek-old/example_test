module Pricing
  module Calculators
    class NumberOfArrays < Base
      def initialize(arrays_number_fetcher)
        super
      end

      def self.call(arrays_number_fetcher: Fetchers::Occurences::Arrays)
        raise ArgumentError if arrays_number_fetcher.blank?

        new(arrays_number_fetcher).call
      end

      private

      def price
        number_fetcher.call.occurence
      end
    end
  end
end
