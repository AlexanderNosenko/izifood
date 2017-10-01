class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :title, null: false
      t.float :price_piece, null: false, default: -1.0
	    t.float :price_volume, default: -1.0
	    t.string :quantifier, null: false, default: '-kg'
	    t.string :min_amount, null: false
      t.string :image
      t.string :tesco_id, null: false
      
      t.timestamps
    end
  end
end
