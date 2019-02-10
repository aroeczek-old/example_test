module Requests
  module ApiHelpers
    extend ActiveSupport::Concern

    included do
    end

    def json
      @json ||= JSON.parse(response.body, symbolize_names: true).with_indifferent_access
    end

    # authenticated :web_app
    # authenticated :web_app, { name: 'example@email.com' }
    def authenticated(*args)
      attributes = args.extract_options!
      context    = args.first
      token      = double :acceptable? => true, scopes: attributes[:scopes] || ''

      allow(controller).to receive(:doorkeeper_token) { token }
    end
  end
end
