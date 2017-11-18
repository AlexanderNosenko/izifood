# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  menu_id    :integer
#  deliver_on :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("ok"), not null
#

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu     
  has_one :delivery, dependent: :destroy
  has_many :order_items, dependent: :delete_all  
  
  has_many :recipe_ingredients, through: :order_items
  has_many :recipes, through: :recipe_ingredients

  accepts_nested_attributes_for :order_items

  validates_uniqueness_of :menu_id, scope: [:deliver_on, :user_id]
  validate :no_active_orders, if: -> { new_record? }

  enum status: [:ok, :user_attention]

  def self.active_order_for(menu)
    Order.joins(<<-EOS 
      LEFT JOIN deliveries 
        ON deliveries.order_id = orders.id 
        AND deliveries.deliver_on > date '#{Time.now.strftime('%Y-%m-%d')}' 
      WHERE
        orders.menu_id = #{menu.id} 
      EOS
    ).first
    #TODO AND deliveries.time_from < time '03:00'
  end

  def items
    order_items.includes(:recipe_ingredient)
  end
  
  def remove_not_mentioned!(order_items_new)
    new_ids = order_items_new.pluck(:id)
    order_items.each do |order_item|
      order_item.destroy unless new_ids.include?(order_item.id.to_s)
    end
  end
  
  # State managment
  def ok!
    self.update_attribute(:status, "ok")
  end
  
  def handle_menu_change
    recalculate_order
    self.update_attribute(:status, "user_attention")
  end
  
  private

  def recalculate_order
    recipes_ids = menu.recipes.pluck(:id)#.uniq#.push(nil) #TODO handle custom order_items
    
    included_recipes_ids = recipes.pluck(:id).uniq
    new_recipes_ids = recipes_ids - included_recipes_ids

    items.each do |item|
      item.destroy unless recipes_ids.include?(item.recipe_ingredient.recipe_id)
    end
    

    new_recipe_ingredient = RecipeIngredient.where(recipe_id: new_recipes_ids).uniq { |r| r.title }
    new_recipe_ingredient.each do |rec_ing|
      items.create({
        ingredient_id: rec_ing.possible_ingredients.first&.id,
        quantity: menu.quantity_for(rec_ing), 
        recipe_ingredient: rec_ing
      })
    end
  end

  def no_active_orders
    if Order.active_order_for(menu)
      errors.add(:order, "Menu is already ordered, please edit the current one or create new.")
    end  
  end
  
end
