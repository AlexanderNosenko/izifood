class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup_menus

  def setup_menus
    @menus = current_user&.menus_with_recipes.to_a
  end

  private
 
  def authenticate_user!
    if current_user
      super
    else
      redirect_to new_user_session_path
    end
  end
end
