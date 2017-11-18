# == Schema Information
#
# Table name: recipes_tags
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecipesTag < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag, class_name: 'RecipeTag'
end
