module Pricing
  module Calculators
    class Letters < Base
      def initialize(leter_number_fetcher)
        super
      end

      def self.call(leter_number_fetcher: Fetchers::Occurences::Letters)
        raise ArgumentError if leter_number_fetcher.blank?

        new(leter_number_fetcher).call
      end

      private

      def price
        number_fetcher.call.occurence / 100.0
      end
    end
  end
end
