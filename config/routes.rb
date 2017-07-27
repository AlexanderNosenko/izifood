Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  mount_roboto
  root 'recipes#index'

  resources :recipes  
  resources :menus
  resources :orders
  get 'ingredients', to: 'ingredients#index'
  post 'ingredients/search', to: 'ingredients#search', as: 'ingredients_search'
  # get 'ingredients/search', to: 'ingredients#search'
  resources :orders

  post 'menus/:menu_id/add_recipe/:recipe_id', to: 'menus#add_recipe', as: 'menus_add_recipe'
  get 'menus/:menu_id/add_recipe/:recipe_id', to: 'menus#add_recipe'
  delete 'menus/:menu_id/remove_recipe/:recipe_id', to: 'menus#remove_recipe', as: 'menus_remove_recipe'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
