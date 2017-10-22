require 'rubygems'
require "nokogiri"
require "rest-client"
# require "active_record"
# require "../../app/models/recipe.rb"
class Parser
	@@site_url = "http://www.doradcasmaku.pl/"
	
	def parse_images_from(page)
		images = parse_image_links_from(page).map do |image_link|
			image_page = Nokogiri::HTML(RestClient.get(image_link))
			sleep 1
			adapt_image_link(image_page.css('.step-image>img').attribute('src'))
		end
		main_image = adapt_image_link(page.css('.recipe-gallery-wrapper>a>img').attribute('src'))
		images.unshift(main_image)
	end

	def parse_description_from(page)
		is_image_desc = page.css('.recipe-content-description>.step-image-wrapper').count == 1

		if is_image_desc
			parse_step_description_from(page)	
		else
			page.css('.recipe-content-description').text.strip
		end
	end


	def parse_ingredients_from(page)
	  page.css('.component-wrapper.to-l').map do |ing|
	    {
	      title: Nokogiri::HTML(ing.to_html).css('strong').text.strip,
	      quantity: Nokogiri::HTML(ing.to_html).css('span:not(.hidden)').text.strip
	    }
	  end 
	end

	def parse_recipe_from(recipe_page)
		puts "New recipe"
		{
			title: recipe_page.css('[itemprop="name"]').text.strip,
			description: parse_description_from(recipe_page),
			ingredients: parse_ingredients_from(recipe_page),
			pics: parse_images_from(recipe_page),
			type:  recipe_page.css('[itemprop="recipeCategory"]').text,
			prep_time: recipe_page.css('[itemprop="totalTime"]')[0].parent.text.strip,
			prep_type: recipe_page.css('.ico-prepere>.recipe-details-value').text,
			cost: recipe_page.css('.ico-cost>.recipe-details-value').text,
			calories: recipe_page.css('.ico-calorycity>.recipe-details-value').text,
			portion_size: recipe_page.css('.ico-people>.recipe-details-value').text,
			main_ingredient: recipe_page.css('.ico-component>.recipe-details-value').text,
			cuisine: recipe_page.css('.ico-cook-type>.recipe-details-value').text,
			veg: recipe_page.css('.ico-for-vegetarian>.recipe-details-value').text,
			grill: recipe_page.css('.ico-for-grill>.recipe-details-value').text
		}
	end

	def get_recipes(from, limit)
		puts "Shit"
		get_recipes_links(from, limit).map do |link|
			recipe_page = Nokogiri::HTML(RestClient.get(link))
			sleep 1
			parse_recipe_from(recipe_page)
		end
	end

	def self.test(page_url)
		Nokogiri::HTML(RestClient.get(page_url))
	end
	
	private
	#Retrive all url for all recipes from site
	def get_recipes_links(from, limit)
		limit = limit - from
		next_page = from / 20 + 1;
		puts "Page: " + next_page.to_s
		recipes_links = [];

		while(recipes_links.count < limit) do 
			url = @@site_url + "przepisy/strona/" + next_page.to_s
			recipes_page = Nokogiri::HTML(RestClient.get(url))
			
			recipes_links.concat(parse_recipes_links_from(recipes_page))
			next_page += 1
			puts "Recipes: " + recipes_links.count.to_s			
		end	

		return recipes_links.slice(0,limit)
	end

	#Get step links for description if aplicable 
	def get_description_links_from(page)
		page.css('.step-carusel-item>a').map.with_index { |link, i|
			next if i == 0 
			link.attribute('href').text
		}.reject { |c| c.nil? }
	end

	def parse_step_description_from(page)
		steps = get_description_links_from(page).map do |link|
			step_page = Nokogiri::HTML(RestClient.get(link))
			sleep 1
			parse_step(step_page)
		end
		steps.unshift(parse_step(page))
	end

	def parse_step(page)
		{
		  description: page.css('.step-content').text.strip,
		  image: adapt_image_link(page.css('.step-image-wrapper>a>img').attribute('src'))
		}
	end
	
	def parse_recipes_links_from(content)
		content.css('.go-to-recipe').map do |recipe_link| 
			recipe_link['href'] 
		end
	end	

	def parse_image_links_from(page)
		page.css('.recipe-gallery-other-images>li>a').map.with_index { |img, i| 
			next if i == 0
			img.attribute("href").text
		}.reject { |c| c.nil? }
	end

	def adapt_image_link(link)
		link.text.gsub(/\/\//, "http://")
	end

end
# parser = Parser.new

# recipe_page = Nokogiri::HTML(RestClient.get("http://www.doradcasmaku.pl/przepis/401451/-swiderki-z-pieczarkami-i-cebula-w-sosie-smietanowym.html"))

# puts parser.get_recipes

# puts parser.parse_ingredients_from(recipe_page)
# puts parser.parse_image_links_from(recipe_page)
# puts parser.parse_description_from(recipe_page)
# puts parser.parse_recipe_from(recipe_page)
