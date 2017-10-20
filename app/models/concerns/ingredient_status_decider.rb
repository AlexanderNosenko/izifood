require 'active_support/concern'
module IngredientStatusDecider
  extend ActiveSupport::Concern
  
  included do
    
  end

  class_methods do
  	def match_statuses
  	  { none: 0, partial: 1, full: 2}	
  	end

  	def status_for(ingredients_count)
	    if ingredients_count == 0
	      :none      
	    elsif ingredients_count < 6
	      :partial
	    else
	      :full
	    end
	end
  end
end