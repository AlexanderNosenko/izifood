class AddAdressToDelivery < ActiveRecord::Migration[5.1]
  def change
    add_reference :deliveries, :delivery_address, null: false
  end
end
