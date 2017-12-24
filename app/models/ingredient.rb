# == Schema Information
#
# Table name: ingredients
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  price_piece  :float            default(-1.0), not null
#  price_volume :float            default(-1.0)
#  quantifier   :string           default("-kg"), not null
#  min_amount   :string           not null
#  image        :string
#  tesco_id     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Ingredient < ApplicationRecord
  @@DOUBLE_SEARCH = false
  mount_uploader :image, IngredientImageUploader

  has_many :order_items, dependent: :delete_all
  has_many :translations, class_name: 'IngredientTranslation', dependent: :delete_all

  validates :title,
            :price_piece, 
            :quantifier, 
            :min_amount, 
            :tesco_id, presence: true

  validates :tesco_id, uniqueness: true

  def self.cache_searches_for(titles)

    @searches_cache = SearchDuplicate.where(value: titles).includes(:origin).map { |search|
      titles = (titles - [search.value])
      [search.value, search.origin.results]
    }.to_h

    IngredientSearch.where(search: titles).each { |search|
      @searches_cache[search.search] = search.results
    }
  end

  def self.search(q, options = {})
    if @searches_cache && @searches_cache[q]

      if options[:init_objects]
        Ingredient.where(id: search.results)
      else
        @searches_cache[q]
      end

    else

      search = prev_search_for(q)

      if search
        if options[:init_objects]
          Ingredient.where(id: search.results)
        else
          search.results
        end
      else
        results = fetch_ingredients(q)
        IngredientSearch.create(search: q, results: results.pluck(:id))
        if options[:init_objects]
          results
        else
          results.pluck(:id)
        end
      end

    end
  end

  private

  def self.prev_search_for(q)
    duplicate = SearchDuplicate.find_by(value: q)
    
    if duplicate
      duplicate.origin
    else
      search_filters = 'search=?' + (@@DOUBLE_SEARCH ? 'AND array_length(results, 1) > 0' : "")
      IngredientSearch.where(search_filters, q).first
    end
  end

  def self.fetch_ingredients(q, options={})
  	tesco_search = TescoSearch.new(result_processor: IngredientSearchProcessor)
  	tesco_search.do(self.translit(q))
  end
  
  def self.translit(q)
  	ActiveSupport::Inflector.transliterate(q).to_s
  end
end

class IngredientSearchProcessor
  def self.launch(data)    
    data.map do |ing|
      self.create_or_return_existing(ing)
    end
  end
  
  def self.create_or_return_existing(ing)
 	  existing = Ingredient.find_by(title: ing[:title])
    if existing
      existing.touch
      existing
    else
      ing[:remote_image_url] = ing[:image]
	    ing.delete(:image)
  	  Ingredient.create(ing)
  	end
  end
end
