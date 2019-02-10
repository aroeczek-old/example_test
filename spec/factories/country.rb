FactoryBot.define do
  factory :country do
    sequence(:code) { |n| "country_#{n}" }
    association :panel_provider, factory: [:panel_provider, :panel_1]

    trait :with_location do
      transient do
        location { nil }
      end

      after :create do |country, evaluator|
        location = evaluator.location || create(:location)
        create(:location_group, country: country, location: location)
      end
    end
  end
end
