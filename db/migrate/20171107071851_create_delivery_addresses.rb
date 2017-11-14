class CreateDeliveryAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_addresses do |t|
      t.string :title, default: 'Home 1'
      t.string :address, null: false
      t.string :flat_number, null: false
      t.jsonb :details, null: false
      t.boolean :default, default: false, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
