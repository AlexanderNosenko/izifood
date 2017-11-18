# == Schema Information
#
# Table name: recipe_tags
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  _type      :integer          default("category"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecipeTag < ApplicationRecord
  scope :categories, -> { where(_type: 'category') }
  scope :filters, -> { where(_type: 'filter') }

  has_many :recipes, through: :recipes_tags

  enum _type: [:category, :filter]
end
