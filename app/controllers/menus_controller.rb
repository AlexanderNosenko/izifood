class MenusController < ApplicationController
  before_action :authenticate_user!
  # protect_from_forgery with: :exception
  
  before_action :set_menu, only: [:add_recipe, :remove_recipe, :show, :edit]
  before_action :set_recipe, only: [:add_recipe, :remove_recipe]
  
  def update
    menu = Menu.find(params[:id])

    if menu.save
      menu.update_current_menu!
      
      render json: {success: menu.main}
    else
      render json: {success: false}
    end
  end

  def create
    menu = current_user.menus.new

    if menu.save
      menu.update_current_menu!

      flash[:success] = "New menu is created!"
    else
      flash[:error] = "Menu Error!"
    end

    redirect_to recipes_path
  end

  def destroy
    menu = current_user.menus.find(params[:id])

    if menu.destroy!
      menu.update_current_menu!

      flash[:success] = "Menu is deleted!"
      # render json: {success: menu.main}
    else
      flash[:success] = "Menu Error!"
      # render json: {success: false}
    end
    redirect_to recipes_path
  end
  
  def remove_recipe
  	respond_to do |format|
      @menu.remove_recipe(@recipe)
	    format.js { render 'menus/_menus.js.erb' }
    end
  end

  private
  
  def set_menu
   @menu = Menu.find(params[:menu_id])
  end

  def set_recipe
  	@recipe = Recipe.find(params[:recipe_id])
  end

  def menu_params
    params.require(:menu).permit(:title)
  end
end
