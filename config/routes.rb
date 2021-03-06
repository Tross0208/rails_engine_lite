Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'api/v1/merchants/:id/items', to: 'api/v1/merchants/items#index'
  get 'api/v1/items/:id/merchant', to: 'api/v1/items/merchants#show'
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
