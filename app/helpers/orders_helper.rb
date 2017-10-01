module OrdersHelper
  def options_for_possible_ingredients(order_item)
	order_item.recipe_ingredient.possible_ingredients.map do |ing|
	  [ing.title, ing.id]
	end
  end
end
