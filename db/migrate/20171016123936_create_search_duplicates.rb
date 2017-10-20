class CreateSearchDuplicates < ActiveRecord::Migration[5.1]
  def change
    create_table :search_duplicates do |t|
      t.string :value, null: false
      t.references :origin, foreign_key: { to_table: :ingredient_searches }, null: false

      t.timestamps
    end
    add_index :search_duplicates, :value, unique: true
  end
end
