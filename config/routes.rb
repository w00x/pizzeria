Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders
      put '/products/:id/store/:store_id', to: 'products#add_store'
      delete '/products/:id/store/:store_id', to: 'products#delete_store'
      resources :products
      put '/stores/:id/product/:product_id', to: 'stores#add_product'
      delete '/stores/:id/product/:product_id', to: 'stores#delete_product'
      resources :stores
    end
  end
end
