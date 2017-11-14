class DeliveryAddress < ApplicationRecord
  belongs_to :user

  validates_presence_of :address, 
                        :flat_number, 
                        :details, 
                        :default
  # validate ->(record){ reco}
end
