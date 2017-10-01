class IngredientSearchProcessor
  def self.launch(data)    
    data.map do |ing|
      self.create_or_return_existing(ing)
    end
  end
  
  def self.create_or_return_existing(ing)
 	existing = Ingredient.where(title: ing[:title])
    if existing.count > 0
      existing.first
    else
      ing[:remote_image_url] = ing[:image]
	  ing.delete(:image)
	  Ingredient.create(ing)
	end
  end
end

class Ingredient < ApplicationRecord
  @@DOUBLE_SEARCH = true

  mount_uploader :image, IngredientImageUploader
  has_many :order_items, dependent: :delete_all
  has_many :translations, class_name: 'IngredientTranslation', dependent: :delete_all

  def self.search(q)
  	searches = IngredientSearch.where(self.search_filters, q)
  	if searches.count > 0
  	  Ingredient.where(id: searches.first.results)
  	else
  	  results = self.fetch_ingredients(q)
  	  IngredientSearch.create(search: q, results: results.pluck(:id))
  	  results
  	end
  end
  private
  def self.search_filters
  	'search=?' + (@@DOUBLE_SEARCH ? 'AND array_length(results, 1) > 0' : "")
  end
  def self.fetch_ingredients(q, options={})
  	tesco_search = TescoSearch.new(result_processor: IngredientSearchProcessor)
  	tesco_search.do(self.translit(q))  	
  end
  
  private
  def self.translit(q)
  	ActiveSupport::Inflector.transliterate(q).to_s
  end
end
