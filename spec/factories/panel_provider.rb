FactoryBot.define do
  factory :panel_provider do
    sequence(:code) { |n| "code_#{n}" }

    trait :panel_1 do
      type { 'Panels::Panel_1' }
    end

    trait :panel_2 do
      type { 'Panels::Panel_2' }
    end

    trait :panel_3 do
      type { 'Panels::Panel_3' }
    end
  end
end
