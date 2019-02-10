FactoryBot.define do
  factory :location do
    name        { 'location' }
    external_id { SecureRandom.uuid }
    secret_code { SecureRandom.uuid }

    trait :with_country do
      transient do
        country { nil }
      end

      after :create do |location, evaluator|
        country = evaluator.country || create(:country)
        create(:location_group, country: country, location: location)
      end
    end
  end
end
