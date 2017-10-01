class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu     
  has_many :order_items, :dependent => :delete_all
  
  accepts_nested_attributes_for :order_items

  def items
  	order_items	
  end
end
