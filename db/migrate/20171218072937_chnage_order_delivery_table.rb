class ChnageOrderDeliveryTable < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :deliver_on_from, :datetime, null: false, index: true
    add_column :deliveries, :deliver_on_to, :datetime, null: false, index: true
  end
end
