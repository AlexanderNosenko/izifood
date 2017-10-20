# == Schema Information
#
# Table name: search_duplicates
#
#  id         :integer          not null, primary key
#  value      :string           not null
#  origin_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchDuplicate < ApplicationRecord
  belongs_to :origin, class_name: 'IngredientSearch'
  validates :value, presence: true, uniqueness: true
end
