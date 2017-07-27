class MenusController < ApplicationController
  # protect_from_forgery with: :exception
  
  before_action :set_menu, only: [:add_recipe, :remove_recipe, :show, :edit, :update, :destroy]
  before_action :set_recipe, only: [:add_recipe, :remove_recipe]

  def index
  	@menus = User.first.menus
  	cd
  end

  def new
  end

  def add_recipe    
    respond_to do |format|
      if @menu.add_recipe(@recipe)
        format.html { redirect_to @menu, notice: 'Recipe was successfully created.' }
        format.json { render json: {status: '200'}, status: :created }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
      @menus = current_user.menus_with_recipes
	  format.js { render 'menus/_menus.js.erb' }
    end
  end

  def remove_recipe
  	respond_to do |format|
      if @menu.remove_recipe(@recipe)
        format.html { redirect_to @menu, notice: 'Recipe was successfully created.' }
        format.json { render json: {status: '200'}, status: :created }
      else
        format.html { render :new }
        format.json { render json: {status: '200'}, status: :unprocessable_entity }
      end
	  @menus = current_user.menus_with_recipes
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
