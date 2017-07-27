require 'rubygems'
require "nokogiri"
require "rest-client"
class IngredientsParser
	@@site_url = "https://ezakupy.tesco.pl/groceries/pl-PL/shop/"
	@@top_categories = ['warzywa-owoce']
	
	# def parse_sub_categories(page)
	# 	page.		
	# end
	# def has_elems(page)
		# return page.css('.tile-content').length > 0
	# end

	def get_ingredients(from, limit)
		puts "Shit"
		ingredients = []
		has_elems = true;
		@@top_categories.each do |cat| 
			page_num = from

			link = @@site_url + cat + "/all?page="
			page = Nokogiri::HTML(RestClient.get(link + page_num.to_s))

			while has_elems do
				puts "page " + page_num.to_s
				ingredients.concat(parse_ingredients_from(page))
				page_num += 1
				
				begin
				  page = Nokogiri::HTML(RestClient.get(link + page_num.to_s))
				rescue
				  has_elems = false
				end
			end
		end
		ingredients
	end

	def parse_ingredients_from(page)
		page.css('.tile-content').map do |ing|
			ing = Nokogiri::HTML(ing.to_html)
			{
				title: ing.css('.product-tile--title').text.gsub(/tesco/i, '').strip,
				# category: "",
				price_piece: get_price_piece_for(ing),
				price_volume: get_price_volume_for(ing),
				quantifier: get_quantifier_for(ing),
				image: ing.css('img').attribute('src').text
			}
		end
	end

	private	
	def get_quantifier_for(ing)
		quantifier = ing.css('.weight').text.gsub('/','').gsub('.','')
		if ing.css('.controls--toggle-text').length > 0
			quantifier
		else
			"szt"
		end
	end

	def get_price_volume_for(ing)
		ing.css('.weight').text != "/szt." ? ing.css('.price-per-quantity-weight .value').text : nil
	end

	def get_price_piece_for(ing)
		ing.css('.price-per-sellable-unit .value').text.gsub(',', '.').to_f
	end
end
# parser = Parser.new

# recipe_page = Nokogiri::HTML(RestClient.get("http://www.doradcasmaku.pl/przepis/401451/-swiderki-z-pieczarkami-i-cebula-w-sosie-smietanowym.html"))

# puts parser.get_recipes

# puts parser.parse_ingredients_from(recipe_page)
# puts parser.parse_image_links_from(recipe_page)
# puts parser.parse_description_from(recipe_page)
# puts parser.parse_recipe_from(recipe_page)
