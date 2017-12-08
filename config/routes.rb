Rails.application.routes.draw do
  root 'recipes#index'
  
  mount_roboto

  devise_for :users, :controllers => { 
    :sessions => "authentication/sessions", 
    :registrations => "authentication/registrations", 
    :passwords => 'authentication/passwords',
    :omniauth_callbacks => 'authentication/omniauth_callbacks'
  }
  
  namespace :admin do
    resources :users
    resources :deliveries
    resources :delivery_slots
    resources :ingredients
    resources :ingredient_searches
    # resources :ingredient_translations
    resources :menus
    # resources :menu_recipes
    resources :orders
    # resources :order_items
    resources :recipes
    # resources :recipe_ingredients
    resources :search_duplicates
    resources :quantity_matches
    resources :promotions
    resources :user_promotions
    resources :payments
    resources :recipe_tags
    resources :recipe_categories
  
    patch 'utils/update_matches', to: 'utils#update_matches', as: 'utils_update_matches'
    patch 'utils/update_slots', to: 'utils#update_slots', as: 'utils_update_slots'

    root to: "users#index"
  end

  resources :recipes, only: %i(index show)
  resources :menus, only: %i(create update destroy)
  resources :menu_recipes, only: %i(create)
  delete 'menu_recipes', to: 'menu_recipes#destroy'
  
  # get '/menus/add_recipe/:recipe_id', to: 'menus#add_recipe'
  # post '/menus/add_recipe/:recipe_id', to: '#createadd_recipe', as: 'add_recipe'
  # delete 'remove_recipe/:recipe_id', to: 'menus#remove_recipe', as: 'remove_recipe'

  resources :orders do
    resources :delivery, controller: "deliveries", only: %i(new create edit update)
    # post 'delivery', to: 'deliveries#create'
  end
  patch 'orders/:id/cancel', to: 'orders#cancel', as: 'cancel_order'

  resources :delivery_addresses, only: %i(create update)
  resources :ingredients, only: %i(index)
  resources :accounts, only: %i(edit update)
  get '/renew_membership', to: 'accounts#renew_membership', as: :renew_membership
  patch '/renew_membership', to: 'accounts#update_membership'
  patch '/use_membership_promo', to: 'accounts#use_membership_promo', as: :use_membership_promo

  get '/promo/:id', to: 'promotions#use_promo', as: :use_promo

  get '/job_status/:job_id', to: 'orders#job_status', as: 'job_status'
end
