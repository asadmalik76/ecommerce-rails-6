# frozen_string_literal: true

# Application Routes
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    resources :sellers
  end

  resources :categories
  resources :brands
  resources :products
  resources :products do
    resources :comments
  end


  resource :carts
  resources :cart_items
  resources :orders
  resources :charges, only: %i[new create]


  get '/all_products', to: 'index#all_products', as: 'all_products'
  post '/apply_coupon', to: 'orders#apply_coupon', as: 'apply_coupon'
  get '/myorders', to: 'orders#myorders', as: 'myorders'
  get '/category_products/:slug', to: 'index#category_products', as: 'category_products'
  get '/brand_products/:slug', to: 'index#brand_products', as: 'brand_products'
  get '/decreament', to: 'cart_items#decreament'
  get '/increament', to: 'cart_items#increament'
  get '/remove_item', to: 'cart_items#remove_item'
  get '/unauthorized', to: 'index#unauthorized'
  get '/notfound', to: 'index#notfound'
  root 'index#index'
end
