class RecipeTag < ApplicationRecord
  scope :categories, -> { where(_type: 'category') }
  scope :filters, -> { where(_type: 'filter') }

  has_many :recipes, through: :recipes_tags

  enum _type: [:category, :filter]
end
