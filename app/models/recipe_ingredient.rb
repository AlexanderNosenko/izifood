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
    if @ingredients
      @ingredients
    else
      ingredient_ids = Ingredient.search(title, { init_objects: false })

      if ingredient_ids.any?
        @ingredients = Ingredient.find_by_sql(
          <<-EOS
            SELECT i.*, (SELECT Count(o.id)
                    FROM   order_items o
                    WHERE  o.recipe_ingredient_id = '#{self.id}'
                           AND o.ingredient_id = i.id
                    ) AS count
            FROM ingredients i
            WHERE  i.id IN (#{ingredient_ids.join(',')})
            ORDER  BY count DESC
          EOS
          )
      else
        []
      end
    end
  end
  
  def update_match
    IngredientMatchesWorker.perform_async(id: id) if title_changed?
    # IngredientMatchesWorker.new.perform_async(id: id) if title_changed?
  end

  private

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