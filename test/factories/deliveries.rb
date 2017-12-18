# == Schema Information
#
# Table name: deliveries
#
#  id                  :integer          not null, primary key
#  deliver_on          :date             not null
#  cost_value          :decimal(5, 2)    not null
#  cost_currency       :string           not null
#  time_from           :string           not null
#  time_to             :string           not null
#  order_id            :integer          not null
#  delivery_address_id :integer          not null
#  deliver_on_from     :datetime         not null
#  deliver_on_to       :datetime         not null
#

FactoryBot.define do
  date = 5.days.from_now

  factory :delivery do
    order
    association :address, factory: :delivery_address
    cost_value { "0" }
    cost_currency { "USD" }
    deliver_on { date }
    time_from { "10:00" }
    time_to { "11:00" }
    
    deliver_on_from { date.change(hour: 10) }
    deliver_on_to {  date.change(hour: 11) }

  end
end
