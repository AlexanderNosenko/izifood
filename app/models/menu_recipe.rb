class MenuRecipe < ApplicationRecord
  validates :menu_id, presence: true, :uniqueness => {:scope => :recipe_id}  
  validates :recipe_id, presence: true

  belongs_to :menu
  belongs_to :recipe
end
