# == Schema Information
#
# Table name: recipe_tags
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  order      :integer          default(0)
#  _type      :integer          default("category"), not null
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecipeTag < ApplicationRecord
  scope :categories, -> { where(_type: 'category') }
  scope :filters, -> { where(_type: 'filter') }

  has_many :recipes, through: :recipes_tags

  # mount_uploaders :icon, RecipeTagIconUploader

  enum _type: [:category, :filter]
end
