# == Schema Information
#
# Table name: menu_recipes
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MenuRecipe < ApplicationRecord
  validates :menu_id, presence: true, :uniqueness => {:scope => :recipe_id}  
  validates :recipe_id, presence: true

  belongs_to :menu
  belongs_to :recipe
end
