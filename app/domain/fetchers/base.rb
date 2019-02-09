module Fetchers
  class Base
    # If the performance issues occur as a further improvement we can make longer cache time and send light
    # HEAD request to gain headers(Last-Modified or Etag) and decide if we have to send request for data and recalculate
    # or just serve data directly from the cache if nothing changed in destination page/response
    DEFAULT_FETCHERS_CACHE_EXPIRATION_SECONDS = 60

    Response = Struct.new(:success, :occurence)

    def initialize(page_url, use_cache)
      @page_url    = page_url
      @use_cache   = use_cache
      @http_client = Faraday.new page_url
      @success     = true
      @response    = nil
      @body        = nil
      @occurence   = nil
    end

    protected

    attr_accessor :page_url, :use_cache, :http_client, :response,
                  :occurence, :body, :success

    def fetch
      self.occurence = use_cache ? fetch_with_cache : fetch_raw
    end

    def fetch_with_cache
      Rails.cache.fetch(cache_key, expires_in: cache_expiration_seconds) { fetch_raw }
    end

    def cache_key
      raise_not_implemented
    end

    def cache_expiration_seconds
      raise_not_implemented
    end

    def fetch_raw
      raise_not_implemented
    end

    def count_occurence
      raise_not_implemented
    end

    private

    def raise_not_implemented
      raise NotImplementedError.new('Should be implemented in subclass')
    end
  end
end
