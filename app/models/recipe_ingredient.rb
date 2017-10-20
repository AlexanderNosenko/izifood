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

  def possible_ingredients
    bandwith = (6 - most_popular_ingredients.count)
    ingredients = Ingredient.search(title).reject { |i| most_popular_ingredients.pluck(:id).include?(i.id) }
    ingredients = ingredients.sort_by { |r| r["updated_at"] }
    @possible_ingredients ||= most_popular_ingredients.concat(ingredients[0..bandwith])    
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
  
  def calc_quantity
    quantity.split(/[[:space:]]/).each_slice(2).map { |q|
      asss if q[0].gsub(',','.').to_f == 0
      puts q[0].to_number.to_s + " " + ingredient.title
      q[0].to_number * ( q[1] + " " + ingredient.title ).to_weight.to_i      
    }[0].to_i
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

class String
  
  def to_weight
    _q_ = self.split(/[[:space:]]/)

    case _q_[0]
    when 'ml', 'g', 'szczypta'
      1 
    when 'łyzeczka'
      5
    when 'łyzka', 'łyzki', 'łyżki', 'łyżka'
      16
    when 'szkl'
      case _q_[1]
      when 'mleko'
        245
      when 'kasza'
        128
      else
        raise ArgumentError("No specification for #{_q_}")
      end
    when 'szt', 'sztuki'
      case _q_[1]
      when 'jajko'
        1
      when 'ziemniaki'
        200
      when 'buraki'
        240
      else
        raise ArgumentError("No specification for #{_q_}")
      end
    when 'litry'
      1000
    else
      raise ArgumentError("No specification for #{_q_}")
    end
  end

  def to_number
    fraction = self.split("/")
    if fraction.length > 1
      fraction.each_slice(2).map { |q|
        fraction[0].to_f / fraction[1].to_f
      }[0].to_f
    else
      self.gsub(',','.').to_f
    end
  end

end
