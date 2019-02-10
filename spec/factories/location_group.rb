FactoryBot.define do
  factory :location_group do
    name           { 'location_group' }
    panel_provider { country.panel_provider }
    country
    location
  end
end
