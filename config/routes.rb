Rails.application.routes.draw do
  resources :plans
  root "home#index"

  get 'most_sales/index'
 
  get "up" => "rails/health#show", as: :rails_health_check

  resources :cart_saveds, only: [:destroy, :show, :index, :create, :recover_sale] do
    member do 
      get 'recover_sale'
    end
  end

  resources :cart_temps do 
    member do 
      get 'add_one_item'
      get 'remove_one_item'
    end

    collection do 
      get 'cart_abandoned'
      get 'cancel'
      get 'new_sale'
      get 'add_with_sanner'
    end
  end
  resources :items do 
    collection do 
      get 'add_cart'
    end 
  end 

  resources :cities, only: [:province] do 
    member do 
      get 'province'
    end
  end

  resources :categories
  resources :companies
  resources :invoice_temps
  resources :invoice_historics
  resources :profiles
  resources :sectors
  resources :suppliers


  devise_for :users, controllers: {registrations: "registrations"}

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
end