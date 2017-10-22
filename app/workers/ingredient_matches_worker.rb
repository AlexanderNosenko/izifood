class IngredientMatchesWorker
  include Sidekiq::Worker
  
  def perform(*args)
    id = args.present? && ( args[0]['id'] || args[0]['id'] )
    if id
      recipe_ingredients = RecipeIngredient.where(id: id)
    else
      recipe_ingredients = RecipeIngredient.all
    end
    recipe_ingredients.each_with_index do |recipe_ingredient, index|
      ingredients = Ingredient.search(recipe_ingredient.title)
      # puts "#{recipe_ingredient.id} ingredient  status_update #{RecipeIngredient.status_for(ingredients.count)}"
      recipe_ingredient.assign_attributes({match: RecipeIngredient.status_for(ingredients.count)})
      recipe_ingredient.save if recipe_ingredient.changed?
    end
  end

  # alias :perform_async :perform
end
