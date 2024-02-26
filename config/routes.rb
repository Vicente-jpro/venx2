Rails.application.routes.draw do
  resources :cart_saveds

  root "home#index"
  
  resources :invoice_historics
  get "up" => "rails/health#show", as: :rails_health_check

  resources :companies
  resources :invoice_temps
  resources :cart_temps do 
    member do 
      get 'add_one_item'
      get 'remove_one_item'
    end

    collection do 
      get 'cart_abandoned'
      get 'cancel'
      get 'new_sale'
    end
  end
  resources :items do 
    collection do 
      get 'add_cart'
    end 
  end 
  resources :categories
  resources :sectors
  resources :suppliers
  resources :profiles
  resources :cities, only: [:province] do 
    member do 
      get 'province'
    end
  end

  devise_for :users, controllers: {registrations: "registrations"}

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  
end