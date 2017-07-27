class Menu < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user
  has_many :menu_recipes
  has_many :recipes, through: :menu_recipes
  
  def add_recipe(recipe)
    menu_recipe = MenuRecipe.new(menu: self, recipe: recipe)
    if !menu_recipe.save
    	self.errors[:menu_recipes] << menu_recipe.errors
 		return false
 	else
 		return true
 	end
  end

  def remove_recipe(recipe)
  	menu_recipe = MenuRecipe.where(menu: self, recipe: recipe).first
    if !menu_recipe.destroy
    	self.errors[:menu_recipes] << menu_recipe.errors
 		return false
 	else
 		return true
 	end
  end

  def ingredients
  	@ingredients ||= recipes.map { |r| r.ingredients }.flatten.uniq
  end

  def quantities
  	@quantities ||= recipes.map { |r| r.recipe_ingredients }.flatten
  end
  
  def quantity_for(ingredient)
  	quantity = 0;
    quantities.each do |rc|
  	  next if rc.ingredient_id != ingredient.id
   	  quantity += rc.calc_quantity
    end
    quantity
  end
  
  def to_order
  	o = Order.new({ user_id: self.user.id, menu_id: self.id })    
    o.order_items = ingredients.map do |ingredient|
      OrderItem.new({ order_id: o.id, ingredient_id: ingredient.id, quantity: quantity_for(ingredient)})
    end
    o
  end

  def recipes_with_ingredients
	recipes.includes(:ingredients).includes(:recipe_ingredients)
  end
  
  def self.create_first_menu_for(user)
  	Menu.create(user: user, title: 'First menu')
  end

  def self.current_menu(menus)
  	menus.where('(deliver_on <= :deliver_on OR deliver_on is NULL) AND main = :main', { deliver_on: DateTime.new + 1.day, main: true }).first
  end

end