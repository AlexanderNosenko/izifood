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
  belongs_to :menu
  belongs_to :recipe

  validates :recipe_id, 
            :menu_id, presence: true

  validates :menu_id, uniqueness: { scope: :recipe_id }  

  after_save ->(record) { record.menu.handle_change }
  after_create ->(record) { record.menu.handle_change }
  after_destroy ->(record) { record.menu.handle_change }

end
