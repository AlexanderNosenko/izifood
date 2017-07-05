Rails.application.routes.draw do
  mount_roboto
  root 'recipes#index'
  resources :recipes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
