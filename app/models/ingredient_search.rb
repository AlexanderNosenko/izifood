class IngredientSearch < ApplicationRecord
  def self.search
  	#TODO introduce matching table
  	# search titile -> ingredients saved in database
  	# where("LOWER(title) similar to ?", '%' + q.downcase + '%').limit(10) unless q.empty?
  end
end
