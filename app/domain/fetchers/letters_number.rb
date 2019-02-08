module Fetchers
  class LettersNumber < Base
    BODY_REGEXP = /<body.*<\/body>/m

    def initialize(page_url, letter_to_count, use_cache)
      super(page_url, use_cache)

      @letter_to_count = letter_to_count
      @text            = ''
    end

    def self.call(page_url: 'http://time.com', letter_to_count: 'a', use_cache: true)
      raise ArgumentError if page_url.blank? || letter_to_count.blank?

      new(page_url, letter_to_count, use_cache).call
    end

    def call
      fetch

      Response.new(success, occurence)
    end

    private

    attr_accessor :letter_to_count, :text

    def fetch_raw
      self.response = http_client.get
      self.body     = response.body.match(BODY_REGEXP).to_s
      self.text     = ActionView::Base.full_sanitizer.sanitize(body.to_s)

      count_occurence
    rescue Faraday::ClientError
      can_not_fetch_page_content
    end

    def count_occurence
      text.count letter_to_count
    end

    def cache_key
      "#{URI.parse(page_url).host}:count:letter:#{letter_to_count}"
    end

    def cache_expiration_seconds
      Rails.application.credentials.dig(Rails.env.to_sym, :LETTER_CACHE_EXPIRATION_SECONDS) ||
        DEFAULT_FETCHERS_CACHE_EXPIRATION_SECONDS
    end

    def can_not_fetch_page_content
      self.success = false
      #Rollbar.logger.error "#{self.class.to_s} can not fetch page content, {page: page_url}"
    end
  end
end
