# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors
Rails.application.config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
  allow do
    #In real project I would use ENV to conf allowed domains/IPs
    domains = Rails.env.development? ? '*' : nil
    origins domains

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['X-Auth-Token']
  end
end
