class CreateIngredientSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_searches do |t|
      t.string :search, null: false
      t.string :results, array: true, default: []

      t.timestamps
    end
    add_index :ingredient_searches, :search, unique: true
  end
end
