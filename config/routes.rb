Rails.application.routes.draw do
  use_doorkeeper

  #If api will be more complicated or need versions I would introduce another level like api/v1/
  namespace :api do
    namespace :public do
    end

    post 'evaluate_target', controller: :panels

    resources :locations, only: [:index] do
      collection do
        get ':country_code', action: :index
      end
    end

    resources :target_groups, only: [:index] do
      collection do
        get ':country_code', action: :index
      end
    end
  end
end
