class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup_menus
  # helper_method :setup_menus
  
  def setup_menus
    @menus = current_user.menus_with_recipes
  end
end
