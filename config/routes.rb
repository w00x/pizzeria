Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders
      resources :products
      post '/products/:id/add_stores', to: 'products#add_stores'
      delete '/products/:id/delete_stores', to: 'products#delete_stores'
      resources :stores
      post '/stores/:id/add_products', to: 'stores#add_products'
      delete '/stores/:id/add_products', to: 'stores#add_products'
    end
  end
end
