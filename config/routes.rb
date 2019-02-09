Rails.application.routes.draw do
  #If api will be more complicated or need versions I would introduce another level like api/v1/
  namespace :api do
    resources :locations, only: [:index] do
      collection do
        get ':country_code', action: :index
      end
    end
  end
end
