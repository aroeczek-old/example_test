FactoryBot.define do
  factory :web_app, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri    { 'https://app.com/callback' }
    scopes          { '' }
  end
end
