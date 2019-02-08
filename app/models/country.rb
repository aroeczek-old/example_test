class Country < ApplicationRecord
  belongs_to :panel_provider

  has_many :country_target_groups, class_name: 'CountriesTargetGroups'
  has_many :location_groups
  has_many :target_groups, through: :country_target_groups

  validates :code, presence: true, uniqueness: true
end
