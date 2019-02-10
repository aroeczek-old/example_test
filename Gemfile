source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

#cors
gem 'rack-cors'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'

#Ruby interface to the PostgreSQL
gem 'pg', '~> 0.18.4'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Simple, efficient background processing for Ruby.
gem 'sidekiq', '~> 5.2', '>= 5.2.5'

#Organise ActiveRecord model into a tree structure
gem 'ancestry', '~> 3.0.5'

#encrypt and decrypt attributes
gem "attr_encrypted", "~> 3.1.0"

#HTTP/REST API client library.
gem 'faraday', '~> 0.15.4'

#cache
gem "redis", "~> 4.1"

# deal with html structures
gem 'nokogiri', '~> 1.6', '>= 1.6.8'

#JSON ouput serializer of objects
gem 'fast_jsonapi', '~> 1.5'

#A simple validation library
gem 'dry-validation', '~> 0.13.0'

#an OAuth 2 provider
gem 'doorkeeper', '~> 5.0', '>= 5.0.2'

group :development, :test do
  # An IRB alternative and runtime developer console
  gem 'pry', '~> 0.10.4'
  gem 'bullet', '~> 5.9'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails'
  gem 'vcr', '4.0.0'
  gem 'database_cleaner', '~> 1.6.2', '>= 1.6.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
