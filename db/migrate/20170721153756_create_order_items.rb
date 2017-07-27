class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.string :quantity
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :ingredient, index: true, foreign_key: true

      t.timestamps
    end
  end
end
