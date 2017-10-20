Rails.application.routes.draw do
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

    patch 'utils/update_matches', to: 'utils#update_matches', as: 'utils_update_matches'

    root to: "users#index"
  end

  devise_for :users, :controllers => { :sessions => "sessions" }
  mount_roboto

  root 'recipes#index'

  resources :recipes, only: %i(index show edit new)
  
  resources :menus do
    resources :recipes, only: %i()
      get 'add_recipe/:recipe_id', to: 'menus#add_recipe'
      post 'add_recipe/:recipe_id', to: 'menus#add_recipe', as: 'add_recipe'
      delete 'remove_recipe/:recipe_id', to: 'menus#remove_recipe', as: 'remove_recipe'
  end
  
  resources :orders do 
    resources :delivery, controller: "deliveries", only: %i(new create)
    get 'delivery_create', to: 'orders#delivery_create'
    get 'delivery', to: 'orders#delivery', as: 'delivery'
  end

  resources :ingredients, only: %i(index) do
    # get 'search', to: 'ingredients#search', as: 'search'
  end

end
