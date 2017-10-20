# == Schema Information
#
# Table name: delivery_slots
#
#  id           :integer          not null, primary key
#  content_html :text             not null
#  vendor       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DeliverySlot < ApplicationRecord
  validates :content_html, 
            :vendor, presence: true

  scope :fresh_for, -> (vendor){
  								where(vendor: vendor.to_s)
  								.where('created_at > ?', 3.hours.ago)
  								.order(created_at: :desc)
  								.limit(1)
  							}

  def self.for(vendor)
	  slots = self.fresh_for(vendor).first

  	if slots.nil?
  	  self.get_new_slots(vendor)
  	else
  	  slots
  	end
  end

  def self.get_new_slots(vendor)
  	@tesco_api = Tesco.new
	  slots_html = @tesco_api.delivery_slots_html
  	self.create!({
  	  content_html: slots_html,
  	  vendor: vendor
  	})
  end

end
