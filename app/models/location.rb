class Location < ApplicationRecord
  # Example model creation Location.new(code: "will_be_encrypted")
  attr_encrypted :code, key: Rails.configuration.x.attr_encryption_key, attribute: 'secret_code'
end
