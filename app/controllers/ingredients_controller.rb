class IngredientsController < ApplicationController
  
  def index
	parse_ingredients
  	render :nothing => true, :status => 200, :content_type => 'text/html'
  end
  
  def search
  	@ingredients = []
  	@ingredients = Ingredient.where("title LIKE ?", '%' + params[:q] + '%').limit(10) unless params[:q].empty?
	respond_to do |format|
	  format.js
	  format.json { render json: {search: params[:q]} }
	end 
  end

  private
  def parse_ingredients
    data = IngredientsParser.new.get_ingredients(13, 99)
    data.each do |ing|
      existing = Ingredient.where('title LIKE ?', '%' + ing[:title] + '%')
      cd
      if existing.count > 0
      	existing.update_all(ing)
      else
	  	i = Ingredient.new(ing)
        i.remote_image_url = ing[:image]
        i.save
  	  end
    end
    # Recipe.convert_to_enum
  end

end
