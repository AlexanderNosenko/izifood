class RecipesTag < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag, class_name: 'RecipeTag'
end
