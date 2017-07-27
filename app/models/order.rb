class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu     
  has_many :order_items#, through: :order_items
  accepts_nested_attributes_for :order_items
  def items
  	order_items	
  end
end
