# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  deliver_on    :date             not null
#  cost_value    :decimal(5, 2)    not null
#  cost_currency :string           not null
#  time_from     :string           not null
#  time_to       :string           not null
#  order_id      :integer          not null
#

class Delivery < ApplicationRecord
  belongs_to :order
  
  validates :deliver_on, 
			:cost_value, 
			:cost_currency, 
			:time_from, 
			:time_to, presence: true
end
