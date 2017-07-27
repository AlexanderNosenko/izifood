class AddColumnsToIngredient < ActiveRecord::Migration[5.1]
  def change
  	add_column :ingredients, :price_piece, :float, null: false, default: -1.0
  	add_column :ingredients, :price_volume, :float, default: -1.0
  	add_column :ingredients, :quantifier, :string, null: false, default: '-kg'
  	add_column :ingredients, :image, :string
  end
end
