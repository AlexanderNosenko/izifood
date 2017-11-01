# == Schema Information
#
# Table name: order_items
#
#  id                   :integer          not null, primary key
#  recipe_ingredient_id :integer          not null
#  order_id             :integer          not null
#  ingredient_id        :integer          not null
#  quantity             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ingredient
  belongs_to :recipe_ingredient

  validates :ingredient, presence: { message: 'Please choose an ingredient' }
  validates :quantity, presence: true

  def possible_ingredients(limit = 0)
    recipe_ingredient.possible_ingredients(limit)
  end

  def possible_quantity
    QuantityMatch.calculate(quantity)    
  end
end
