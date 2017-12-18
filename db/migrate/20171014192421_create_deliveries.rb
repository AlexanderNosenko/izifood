class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|   
  	  t.date :deliver_on, index: true, null: false
  	  t.decimal :cost_value, precision: 5, scale: 2, null: false
  	  t.string :cost_currency, max: 10, null: false
  	  t.string :time_from, null: false
  	  t.string :time_to, null: false
  	  t.belongs_to :order, index: true, null: false

      t.timestamps
    end
  end
end
