class Recipe < ApplicationRecord

  mount_uploaders :images, RecipeImageUploader
  mount_uploaders :desc_images, DescriptionImageUploader
  
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  
  enum r_type: { Inne: 0, Obiad: 1, Deser: 2, Zupa: 3, Przystawka: 4, Kolacja: 5, Napój: 6, Śniadanie: 7, 'Ciasto słodkie' => 8 }, _prefix: true
  enum prep_time: { Inne: 0, Szybko: 1, Średnio: 2, Długo: 3 }, _prefix: true
  enum prep_type: { Inne: 0, Marynowanie: 1, Gotowane: 2, Smażone: 3, Pieczenie: 4, Duszone: 5}, _prefix: true
  enum cost: { Inne: 0, Niski: 1, Średni: 2 }, _prefix: true
  enum calories: { Inne: 0,  Niska: 1, Średnia: 2, Wysoka: 3 }, _prefix: true
  enum portion_size: { Inne: 0, '1-2' => 1, '3-4' => 2, '5+' => 3 }, _prefix: true
  enum main_ingredient: { Inne: 0, Drób: 1, 'Kasza/ryż' => 2, 'Ryby i owoce morza' => 3, Wieprzowina: 4, Warzywa: 5, Grzyby: 6, Sery: 7, Owoce: 8, Makarony: 9 }, _prefix: true
  enum cuisine: { Inna: 0,  polska: 1, włoska: 2, skandynawska: 3, japońska: 4, indyjska: 5 }, _prefix: true

  def self.create_from(data)
  	r = Recipe.new
  	r.title = data[:title]
  	r.remote_images_urls = data[:pics]	
  	r.r_type = data[:type]
  	r.prep_time = data[:prep_time]
  	r.prep_type = data[:prep_type]
  	r.cost = data[:cost]
  	r.calories = data[:calories]
  	r.portion_size = data[:portion_size]
  	r.main_ingredient = data[:main_ingredient]
  	r.cuisine = data[:cuisine]
  	r.veg = data[:veg] == 'Nie' ? false : true
  	r.grill = data[:grill] == 'Nie' ? false : true
  	if data[:description].kind_of?(Array)
  		r.description = data[:description].map { |step| step[:description]}
  		r.remote_desc_images_urls = data[:description].map { |step| step[:image]}
  	else
		r.description = [data[:description]]
  	end
  	if r.save
  		r
  	else
  		raise 'An error has occured'
  	end
  end
  def self.convert_to_enum
  	
  	e_r_type = { 0 => :Inne, 1 => :Obiad, 2 => :Deser, 3 => :Zupa, 4 => :Przystawka, 
  		5 => :Kolacja, 6 => :Napój, 7 => :Śniadanie, 8 => 'Ciasto słodkie'}
  	e_prep_time = { 0 => :Inne, 1 => :Szybko, 2 => :Średnio, 3 => :Długo }
  	e_prep_type = { 0 => :Inne, 1 => :Marynowanie, 2 => :Gotowane, 3 => :Smażone, 4 => :Pieczenie, 5 => :Duszone }
  	e_cost = { 0 => :Inne, 1 => :Niski, 2 => :Średni }
    e_calories = {  0 => :Inne,  1 => :Niska, 2 => :Średnia, 3 => :Wysoka }
    e_portion_size = { 0 => :Inne, 1 => '1-2', 2 => '3-4', 3 => '5+' }
    e_main_ingredient = { 0 => :Inne, 1 => :Drób, 2 => 'Kasza/ryż', 3 => 'Ryby i owoce morza', 4 => :Wieprzowina, 
    	5=> :Warzywa, 6 => :Grzyby, 7 => :Sery, 8 =>  :Owoce, 9=> :Makarony}
    e_cuisine = { 0 => :Inna,  1 => :polska, 2 => :włoska, 3 => :skandynawska, 4 => :japońska, 5 => :indyjska }

	Recipe.where("id > 20").each do |recipe|
	  recipe.r_type =  e_r_type.select { |key, value| value.to_s.match(/#{recipe.r_type}/)}.keys[0]
	  recipe.prep_time =  e_prep_time.select { |key, value| value.to_s.match(/#{recipe.prep_time}/)}.keys[0]
	  recipe.prep_type =  e_prep_type.select { |key, value| value.to_s.match(/#{recipe.prep_type}/)}.keys[0]
	  recipe.cost =  e_cost.select { |key, value| value.to_s.match(/#{recipe.cost}/)}.keys[0]
	  recipe.calories =  e_calories.select { |key, value| value.to_s.match(/#{recipe.calories}/)}.keys[0]
	  recipe.portion_size =  e_portion_size.select { |key, value| value.to_s.match(/#{recipe.portion_size}/)}.keys[0]
	  recipe.main_ingredient =  e_main_ingredient.select { |key, value| value.to_s.match(/#{recipe.main_ingredient}/)}.keys[0]
	  recipe.cuisine =  e_cuisine.select { |key, value| value.to_s.match(/#{recipe.cuisine}/)}.keys[0]
	  recipe.save
	end  	

  end
end
