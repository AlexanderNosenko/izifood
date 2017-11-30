class RecipesCategory < ApplicationRecord
  belongs_to :category, class_name: "RecipeCategory"
  belongs_to :recipe
end
