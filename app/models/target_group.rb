class TargetGroup < ApplicationRecord
  # Example model creation TargetGroup.new(code: "will_be_encrypted")
  attr_encrypted :code, key: Rails.configuration.x.attr_encryption_key, attribute: 'secret_code'
  has_ancestry ancestry_column: :parent_id

  belongs_to :panel_provider

  has_many :country_target_groups, class_name: 'CountriesTargetGroups'
  has_many :countries, through: :country_target_group
end
