Sidekiq.configure_server do |config|
  config.redis = { url: "redis://" \
                        "#{Rails.application.credentials.dig(Rails.env.to_sym, :REDIS_HOST) || 'gat_redis'}:" \
                        "#{Rails.application.credentials.dig(Rails.env.to_sym, :REDIS_PORT) || 6379}/12" }
end

Sidekiq.configure_client do |config|
   config.redis = { url: "redis://" \
                         "#{Rails.application.credentials.dig(Rails.env.to_sym, :REDIS_HOST) || 'gat_redis'}:" \
                         "#{Rails.application.credentials.dig(Rails.env.to_sym, :REDIS_PORT) || 6379}/12" }
end
