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

class Delivery < ApplicationRecord
  belongs_to :order
  belongs_to :address, class_name: "DeliveryAddress", foreign_key: :delivery_address_id

  validates :deliver_on,
            :cost_value,
            :cost_currency,
            :time_from,
            :time_to,
            :deliver_on_from,
            :deliver_on_to, presence: true

  validate :no_deliveries_set, if: -> { new_record? }

  def date
    "#{deliver_on} #{time_from}-#{time_to}"
  end

  def no_deliveries_set
    if Delivery.where('order_id = ?', order_id).count != 0
      errors.add(:delivery_set, "can't delivery order more then 1 time")
    end
  end
end
