class CreateDeliverySlots < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_slots do |t|
      t.text :content_html, null: false
      t.string :vendor, null: false
      
      t.timestamps
    end
  end
end
