module Fetchers
  module Occurences
    class Arrays < Base
      DEFAULT_URL = 'http://openlibrary.org/search.json?q=the+lord+of+the+rings'.freeze
      MIN_NUMBER_OF_ELEMENTS = 10

      def initialize(page_url, use_cache)
        super(page_url, use_cache)

        @body = nil
      end

      def self.call(page_url: DEFAULT_URL, use_cache: true)
        raise ArgumentError if page_url.blank?

        new(page_url, use_cache).call
      end

      def call
        fetch

        Response.new(success, occurence)
      end

      private

      attr_accessor :body

      def fetch_raw
        self.response = http_client.get
        self.body     = JSON.parse(response.body)

        count_occurence
      rescue JSON::ParserError => e
        can_not_parse_response(e.message)
      rescue Faraday::ClientError
        can_not_fetch_page_content
      end

      def count_occurence
        body.extend CoreExtensions::Hash::ArraysCounter

        body.number_of_arrays(min_elements: MIN_NUMBER_OF_ELEMENTS)
      end

      def cache_key
        "#{URI.parse(page_url).host}:count:arrays"
      end

      def cache_expiration_seconds
        Rails.application.credentials.dig(Rails.env.to_sym, :ARRAY_CACHE_EXPIRATION_SECONDS) ||
          DEFAULT_FETCHERS_CACHE_EXPIRATION_SECONDS
      end

      def can_not_fetch_page_content
        self.success = false
        #Rollbar.logger.error "#{self.class.to_s} can not fetch page content, {page: page_url}"
      end

      def can_not_parse_response(message)
        self.success = false
        #Rollbar.logger.error "#{self.class.to_s} can not parse json response, {page: page_url, message: message}"
      end
    end
  end
end
