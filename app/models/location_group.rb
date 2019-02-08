class LocationGroup < ApplicationRecord
  belongs_to :country
  belongs_to :location
  belongs_to :panel_provider

  validates  :location, uniqueness: { scope: :country,
    message: I18n.t('errors.location_group.duplicated_for_country')}
end
