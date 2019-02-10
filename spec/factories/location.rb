FactoryBot.define do
  factory :location do
    name        { 'location' }
    external_id { SecureRandom.uuid }
    secret_code { SecureRandom.uuid }
  end
end
