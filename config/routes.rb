Rails.application.routes.draw do
  root 'recipes#index'

  mount_roboto
  devise_for :users, :controllers => { :sessions => "sessions" }

  namespace :admin do
    resources :users
    resources :deliveries
    resources :delivery_slots
    resources :ingredients
    resources :ingredient_searches
    resources :ingredient_translations
    resources :menus
    resources :menu_recipes
    resources :orders
    resources :order_items
    resources :recipes
    resources :recipe_ingredients
    resources :search_duplicates
    resources :quantity_matches

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
  resources :delivery_addresses, only: %i(create update)

  resources :ingredients, only: %i(index)
  get '/job_status/:job_id', to: 'orders#job_status', as: 'job_status'
end
