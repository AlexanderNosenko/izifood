class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def self.add_ingredients_from(data, recipe)

  	data[:ingredients].each do |ing|
  	  ingredient = Ingredient.find_or_create_by(title: ing[:title])
  	  
  	  ri = RecipeIngredient.new
      ri.recipe = recipe
	  ri.ingredient = ingredient
	  ri.quantity = ing[:quantity]
      ri.save
  	end

  end
end
