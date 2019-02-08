module Fetchers
  class NodesNumber < Base
    HTML_REGEXP = /<html.*<\/html>/m

    def initialize(page_url, use_cache)
      super(page_url, use_cache)

      @content = ''
    end

    def self.call(page_url: 'http://time.com', use_cache: true)
      raise ArgumentError if page_url.blank?

      new(page_url, use_cache).call
    end

    def call
      fetch

      Response.new(success, occurence)
    end

    private

    attr_accessor :content

    def fetch_raw
      self.response = http_client.get
      self.body     = response.body.match(HTML_REGEXP).to_s

      count_occurence
    rescue Faraday::ClientError
      can_not_fetch_page_content
    end

    def count_occurence
      document = Nokogiri::HTML(body)
      document.search('*').map(&:name).size

    rescue Nokogiri::SyntaxError => e
      can_not_parse_html_content(e.message)
    end

    def cache_key
      "#{URI.parse(page_url).host}:count:nodes"
    end

    def cache_expiration_seconds
      Rails.application.credentials.dig(Rails.env.to_sym, :NODE_CACHE_EXPIRATION_SECONDS) ||
        DEFAULT_FETCHERS_CACHE_EXPIRATION_SECONDS
    end

    def can_not_parse_html_content(message)
      self.success = false
      #Rollbar.logger.error "#{self.class.to_s} can parse page content, {page: page_url, message: message }"
    end

    def can_not_fetch_page_content
      self.success = false
      #Rollbar.logger.error "#{self.class.to_s} can not fetch page content, {page: page_url}"
    end
  end
end
