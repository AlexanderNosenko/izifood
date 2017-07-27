class String
  
  def to_weight
    _q_ = self.split(/[[:space:]]/)

    case _q_[0]
    when 'ml', 'g', 'szczypta'
      1 
    when 'łyzeczka'
      5
    when 'łyzka', 'łyzki'
      16
    when 'szkl'
      case _q_[1]
      when 'mleko'
        245
      when 'kasza'
        128
      else
        cdcdcd
      end
    when 'szt'
      case _q_[1]
      when 'jajko'
        1
      else
        cdcd
      end
    else
      cd
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

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  
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
