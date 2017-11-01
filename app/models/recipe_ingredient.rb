# == Schema Information
#
# Table name: recipe_ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  quantity   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           default(""), not null
#  match      :integer          default("none"), not null
#

class RecipeIngredient < ApplicationRecord
  include IngredientStatusDecider
  
  belongs_to :recipe

  enum match: match_statuses, _prefix: true
  
  after_save :update_match

  def possible_ingredients(limit = 0)
    limit_index = limit - 1
    bandwith = limit_index - most_popular_ingredients.count

    @ingredients ||= Ingredient.search(title).reject { |i|
      most_popular_ingredients.pluck(:id).include?(i.id)
    }.sort_by { |r| 
      r["updated_at"] 
    }
    result = [].concat(most_popular_ingredients).concat(@ingredients[0..bandwith])
    result[0..limit_index]
  end

  def most_popular_ingredients
    ingredients = Ingredient.where(id: ranked_order_items.pluck(:ingredient_id))
    @most_popular_ingredients ||= sort_by_rank(ingredients)
  end
  
  def update_match
    IngredientMatchesWorker.perform_async(id: id) if title_changed?
    # IngredientMatchesWorker.new.perform_async(id: id) if title_changed?
  end

  private
  def sort_by_rank(ingredients)
    ingredients.to_a.sort { |ing_1, ing_2| rank_for(ing_2) <=> rank_for(ing_1) }
  end

  def rank_for(ing)
    ranked_order_items.reject { |o| ing.id != o.ingredient_id }.first.count  
  end

  def ranked_order_items
    popularity_sql = <<-EOS
      SELECT b.*,
             (SELECT Count(o.*) 
              FROM   order_items o 
                     INNER JOIN recipe_ingredients 
                             ON recipe_ingredients.id = o.recipe_ingredient_id 
              WHERE  o.recipe_ingredient_id = '#{self.id}' 
                     AND o.ingredient_id = b.ingredient_id
              ) AS count 
      FROM   order_items b
      WHERE  b.recipe_ingredient_id = '#{self.id}'
      ORDER  BY count DESC
    EOS
    @ranked_order_items ||= OrderItem.find_by_sql(popularity_sql).uniq { |b| b.ingredient_id }
  end

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