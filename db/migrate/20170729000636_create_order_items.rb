class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      
      t.belongs_to :recipe_ingredient, index: true, foreign_key: true, null: false
      t.belongs_to :order, index: true, foreign_key: true, null: false
      t.belongs_to :ingredient, index: true, foreign_key: true, null: false
      t.string :quantity

      t.timestamps
    end
  end
end
