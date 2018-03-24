require 'rubygems'
require "nokogiri"
require "rest-client"
class IngredientsParser
	@@site_url = "https://ezakupy.tesco.pl/groceries/pl-PL/shop/"
	@@top_categories = ['warzywa-owoce', 'pieczywo-cukiernia', 'mieso-ryby-garmaz', 'nabial-i-jaja']

	# def parse_sub_categories(page)
	# 	page.
	# end
	# def has_elems(page)
		# return page.css('.tile-content').length > 0
	# end

	def get_ingredients(from, limit)
		puts "Shit"
		ingredients = []
		@@top_categories.each do |cat|
			page_num = from
			puts 'cat: ' + cat
			link = @@site_url + cat + "/all?page="
			page = Nokogiri::HTML(RestClient.get(link + page_num.to_s))
			has_elems = true;

			while has_elems && page_num <= limit do
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
			ing_id = ing.attr('id')
			ing = Nokogiri::HTML(ing.to_html)
			{
				title: adapt_title(get_title_for(ing)),
				# category: "",
				tesco_id: ing_id,
				price_piece: get_price_piece_for(ing),
				price_volume: get_price_volume_for(ing),
				quantifier: get_quantifier_for(ing),
				min_amount: get_min_amount_for(ing),
				image: ing.css('img').attribute('src').text
			}
		end
	end

	private
	def get_title_for(ing)
		ing.css('.product-tile--title').text.gsub(/tesco/i, '').strip
	end

	def adapt_title(title)
		title.strip
		# title.gsub(/(\d+|\d,\d+)\s\w+/, '').strip
	end

	def get_quantifier_for(ing)
		quantifier = ing.css('.weight').text.gsub('/','').gsub('.','')
		if ing.css('.controls--toggle-text').length > 0
			quantifier
		else
			"szt"
		end
	end

	def get_price_volume_for(ing)
		ing.css('.weight').text != "/szt." ? ing.css('.price-per-quantity-weight .value').text.gsub(',', '.').to_f : nil
	end

	def get_price_piece_for(ing)
		ing.css('.price-per-sellable-unit .value').text.gsub(',', '.').to_f
	end

	def get_min_amount_for(ing)
		matches = /(\d+|\d,\d+)\s\w+/.match(get_title_for(ing))
		quantifier = get_quantifier_for(ing)
		if matches
			matches[0]
		elsif quantifier == 'kg'
			(1000 / (get_price_volume_for(ing) / get_price_piece_for(ing))).to_i.to_s + " g"
		elsif quantifier == 'szt'
			'1 szt'
		end
	end
end
# parser = Parser.new

# recipe_page = Nokogiri::HTML(RestClient.get("http://www.doradcasmaku.pl/przepis/401451/-swiderki-z-pieczarkami-i-cebula-w-sosie-smietanowym.html"))

# puts parser.get_recipes

# puts parser.parse_ingredients_from(recipe_page)
# puts parser.parse_image_links_from(recipe_page)
# puts parser.parse_description_from(recipe_page)
# puts parser.parse_recipe_from(recipe_page)
