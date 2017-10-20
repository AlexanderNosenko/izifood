class AddUniqueIndexOnIngredient < ActiveRecord::Migration[5.1]
  def change
  	add_index :ingredients, :title, unique: true
  end
end
