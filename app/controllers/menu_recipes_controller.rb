class MenuRecipesController < ApplicationController

  def create
    menu = current_user.current_menu
    menu_recipe = MenuRecipe.new(menu: menu, recipe_id: params[:recipe_id])
    menu_recipe.save
    
    # if menu_recipe.save
    @menus = current_user.menus_with_recipes
    render 'menus/_menus.js.erb'
    # else
    # end
  end

  def destroy
    menu = current_user.current_menu
    menu_recipe = MenuRecipe.find_by(menu: menu, recipe_id: params[:recipe_id])
    menu_recipe.destroy

    # if menu_recipe.destroy
    @menus = current_user.menus_with_recipes
    render 'menus/_menus.js.erb'
    # else
    # end
  end

end
