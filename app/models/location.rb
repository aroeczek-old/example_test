class Location < ApplicationRecord
  # Example model creation Location.new(code: "will_be_encrypted")
  attr_encrypted :code, key: Rails.configuration.x.attr_encryption_key, attribute: 'secret_code'

  has_many :location_groups, dependent: :destroy

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
end
