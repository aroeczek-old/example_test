FactoryBot.define do
  factory :country do
    sequence(:code) { |n| "country_#{n}" }
    panel_provider
  end
end
