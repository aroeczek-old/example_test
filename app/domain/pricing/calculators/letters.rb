module Pricing
  module Calculators
    class Letters < Base
      def initialize(leter_number_fetcher)
        super
      end

      def self.call(leter_number_fetcher: Fetchers::LettersNumber)
        raise ArgumentError if leter_fetcher.blank?

        new(leter_number_fetcher).call
      end

      private

      def price
        number_fetcher.call / 100
      end
    end
  end
end
