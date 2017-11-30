# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  title      :string
#  recurring  :boolean          default(FALSE)
#  main       :boolean          default(TRUE), not null
#  deliver_on :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0), not null
#

class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_recipes, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :recipes, through: :menu_recipes
  
  validates :user_id, presence: true
  
  after_initialize :set_defaul_title, if: ->(record){ record.title.nil? }
  def set_defaul_title
    self.title = "Menu #{self.id}"
  end

  #Can be called from menu_recipe when updated
  def handle_change
    active_order.handle_menu_change if active_order
  end

  #TODO refactor + handle case when current_manu is set, and is not the one deleted
  def update_current_menu!
    user_menus = self.user.menus.order(created_at: :asc)
    Menu.where(id: user_menus.pluck(:id)).update_all(main: false)
    
    if self.destroyed?
      user_menus.first.update_attribute(:main, true)  
    else
      Menu.find(self.id).update_attribute(:main, true)
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

  def to_order
    o = Order.new({ user_id: self.user_id, menu_id: self.id })
    o.order_items = recipe_ingredients.uniq { |r| r.title }.map do |rec_ing|
      OrderItem.new({ 
        order_id: o.id, 
        ingredient_id: rec_ing.possible_ingredients.first.try(:id), 
        quantity: quantity_for(rec_ing), 
        recipe_ingredient: rec_ing
      })
    end
    o
  end

  def active_order
    @active_order ||= Order.active_order_for(self)
  end

  def quantity_for(rec_ing)
    recipe_ingredients.map { |ri|
      next if ri.title != rec_ing.title
      ri.quantity
    }.reject { |q| q.nil? || q.empty? }
     .join(QuantityMatch::JOIN_SYM)
  end
  
  def recipe_ingredients
    #TODO change to has_may :through
    @recipe_ingredients ||= recipes.map { |r| r.recipe_ingredients }.flatten
  end

  def self.create_first_menu_for(user)
  	Menu.create(user: user, title: 'First menu', main: true)
  end

  # def self.current_menu(menus)
  # 	menus.where('(deliver_on <= :deliver_on OR deliver_on is NULL) AND main = :main', { deliver_on: DateTime.new + 1.day, main: true }).first
  # end

end
