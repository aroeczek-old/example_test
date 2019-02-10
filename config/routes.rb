Rails.application.routes.draw do
  use_doorkeeper

  concern :country_code do
    collection do
      get ':country_code', action: :index
    end
  end

  #If api will be more complicated or need versions I would introduce another level like api/v1/
  namespace :api do
    namespace :public do
      resources :locations, only: [:index] do
        concerns :country_code
      end

      resources :target_groups, only: [:index] do
        concerns :country_code
      end
    end

    post 'evaluate_target', controller: :panels

    resources :locations, only: [:index] do
      concerns :country_code
    end

    resources :target_groups, only: [:index] do
      concerns :country_code
    end
  end
end
