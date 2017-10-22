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
  validates_uniqueness_of :menu_id, scope: [:deliver_on, :user_id]
  validate :no_active_orders

  def no_active_orders
    orders = Order.joins(<<-EOS 
      INNER JOIN deliveries 
        ON deliveries.order_id = orders.id 
        AND deliveries.deliver_on > date '#{Time.now.strftime('%Y-%m-%d')}' 
      EOS
    )#TODO AND deliveries.time_from < time '03:00'

    if orders.count > 0
      errors.add(:active_order_exists, "can't add new order before old is realised")
    end  
  end

  def items
  	order_items	
  end
end
