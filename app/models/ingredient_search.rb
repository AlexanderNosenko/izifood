# == Schema Information
#
# Table name: ingredient_searches
#
#  id         :integer          not null, primary key
#  search     :string           not null
#  results    :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IngredientSearch < ApplicationRecord
  has_many :duplicates, class_name: "SearchDuplicate", foreign_key: "origin_id", dependent: :destroy

  validates :search, presence: true, uniqueness: true
end
