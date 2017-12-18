class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    # Recipe.update_tags_and_filters    
    # current_user.give_trial_promo!
    # current_user.give_influencer_promo!
    # Order.update_delivery_statuses

    recipes = Recipe.filter(params)
      .paginate(:page => params[:page], :per_page => 6)
      # .where("title <> 'Inne'")

    categories = RecipeCategory.order(order: :desc)
    categories = prepend_chosen(categories, params[:category])
    
    filters = RecipeTag.filters.order(order: :desc)
    filters = prepend_chosen(filters, params[:filter])

    locals = {
      recipes: recipes,
      categories: categories,
      filters: filters,
      show_all_filters: params[:category].present? || params[:filter].present? || params[:q].present?
    }
    
    respond_to do |format|
      format.html { render locals: locals }
      format.js { render 'recipes/_list.js.erb', locals: locals }
    end
  
  end

  def show;end

  private

  def prepend_chosen(tags, chosen)
    tags = tags.to_a
    tags.each_with_index do |tag, index|
      if tag.id.to_s == chosen.to_s
        temp = tags[index]
        tags[index] = tags[0]
        tags[0] = temp
      end
    end
    tags
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end

  def parse_recipes
    data = Parser.new.get_recipes(41, 99)
    data.each do |r|
      recipe = Recipe.create_from(r)
      RecipeIngredient.add_ingredients_from(r, recipe)
    end
    Recipe.convert_to_enum
  end
end
