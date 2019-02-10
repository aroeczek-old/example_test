module Pricing
  module Calculators
    class HtmlNodes < Base
      def initialize(html_nodes_number_fetcher)
        super
      end

      def self.call(html_nodes_number_fetcher: Fetchers::Occurences::HtmlNodes)
        raise ArgumentError if html_nodes_number_fetcher.blank?

        new(html_nodes_number_fetcher).call
      end

      private

      def price
        number_fetcher.call.occurence / 100.0
      end
    end
  end
end
