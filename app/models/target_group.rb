class TargetGroup < ApplicationRecord
  # Example model creation TargetGroup.new(code: "will_be_encrypted")
  attr_encrypted :code, key: Rails.configuration.x.attr_encryption_key, attribute: 'secret_code'
  # I could make relation in rails to self, but decided not to waste my time
  has_ancestry ancestry_column: :parent_id

  belongs_to :panel_provider

  has_many :country_target_groups, class_name: 'CountriesTargetGroups'
  has_many :countries, through: :country_target_groups

  scope :with_countries, -> { joins(:countries) }

  scope :by_country_code, ->(code) do
    with_countries.where(countries: {code: code})
  end
end
