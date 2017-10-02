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
  def self.search
  	#TODO introduce matching table
  	# search titile -> ingredients saved in database
  	# where("LOWER(title) similar to ?", '%' + q.downcase + '%').limit(10) unless q.empty?
  end
end
