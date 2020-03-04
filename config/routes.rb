Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders
      resources :products
      resources :stores
    end
  end
end
