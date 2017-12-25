class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = []
    @ingredients = Ingredient.where('title ~* ?', params[:q]).limit(10)#.search(params[:q], init_objects: true)

    respond_to do |format|
      format.js
      format.json { render json: {search: params[:q]} }
      format.html { render @ingredients }
    end
  end
  
  private

  def parse_ingredients
    data = IngredientsParser.new.get_ingredients(1, 300)
    data.each do |ing|
      # existing = Ingredient.where('title LIKE ?', '%' + ing[:title] + '%')
      # if existing.count > 0
      # 	existing.update_all(ing)
      # else
        i = Ingredient.new(ing)
        i.remote_image_url = ing[:image]
        i.save
      # end
    end
    # Recipe.convert_to_enum
  end

end
