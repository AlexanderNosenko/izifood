# == Schema Information
#
# Table name: delivery_addresses
#
#  id          :integer          not null, primary key
#  title       :string           default("Home 1")
#  address     :string           not null
#  flat_number :string           not null
#  details     :jsonb            not null
#  default     :boolean          default(FALSE), not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DeliveryAddress < ApplicationRecord
  belongs_to :user

  validates_presence_of :address, 
                        :flat_number, 
                        :details, 
                        :default
  # validate ->(record){ reco}
end
