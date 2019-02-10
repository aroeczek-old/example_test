FactoryBot.define do
  factory :target_group do
    name        { 'target' }
    external_id { SecureRandom.uuid }
    secret_code { SecureRandom.uuid }
    parent_id   { nil }

    association :panel_provider, factory: [:panel_provider, :panel_1]

    trait :with_country do
      transient do
        country { nil }
      end

      after :create do |target_group, evaluator|
        country = evaluator.country || create(:country)
        create(:country_target_group, country: country, target_group: target_group)
      end
    end

    trait :child do
      parent { create :target_group }
    end
  end
end
