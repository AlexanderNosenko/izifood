class OrderItem < ApplicationRecord
  
  belongs_to :order
  belongs_to :ingredient
  belongs_to :recipe_ingredient

  validates :ingredient, presence: { message: 'Please choose an ingredient' }

end
