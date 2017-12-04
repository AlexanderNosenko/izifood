# == Schema Information
#
# Table name: recipes_categories
#
#  id          :integer          not null, primary key
#  recipe_id   :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class RecipesCategory < ApplicationRecord
  belongs_to :category, class_name: "RecipeCategory"
  belongs_to :recipe
end
