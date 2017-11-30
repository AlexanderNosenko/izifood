class RecipeCategory < ApplicationRecord
  belongs_to :parent, class_name: 'RecipeCategory', optional: true
end
