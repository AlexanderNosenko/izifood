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
#

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu     
  has_one :delivery, dependent: :destroy
  has_many :order_items, dependent: :delete_all
  
  accepts_nested_attributes_for :order_items
  # after_update -> { remove_not_mentioned(true) }

  validates_uniqueness_of :menu_id, scope: [:deliver_on, :user_id]
  validate :no_active_orders#, if: -> { new_record? }

  def no_active_orders
    orders = Order.active_orders_for(menu)

    if orders.count > 0
      errors.add(:order, "Menu is already ordered, please edit the current one or create new.")
    end  
  end

  def self.active_orders_for(menu)
    Order.joins(<<-EOS 
      INNER JOIN deliveries 
        ON deliveries.order_id = orders.id 
        AND deliveries.deliver_on > date '#{Time.now.strftime('%Y-%m-%d')}' 
        AND orders.menu_id = #{menu.id} 
      EOS
    )#TODO AND deliveries.time_from < time '03:00'
  end

  def remove_not_mentioned!(order_items_new)
    new_ids = order_items_new.pluck(:id)
    order_items.each do |order_item|
      order_item.destroy unless new_ids.include?(order_item.id.to_s)
    end
  end

  def items
  	order_items	
  end
end
