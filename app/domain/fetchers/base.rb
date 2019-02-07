module Fetchers
  class Base
    def initialize(page_url, use_cache)
      @page_url    = page_url
      @use_cache   = use_cache
      @http_client = Faraday.new page_url
      @response    = nil
      @body        = nil
      @occurence   = nil
    end

    protected

    attr_accessor :page_url, :use_cache, :http_client, :response, :occurence, :body

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

    private

    def raise_not_implemented
      raise NotImplementedError.new('Should be implemented in subclass')
    end
  end
end
