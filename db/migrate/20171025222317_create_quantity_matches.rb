class CreateQuantityMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :quantity_matches do |t|
      t.string :key
      t.string :value
      t.string :quantifier
      t.belongs_to :origin, foreign_key: { to_table: :quantity_matches }, null: true

      t.timestamps
    end
    add_index :quantity_matches, :key, unique: true
    add_index :quantity_matches, :quantifier
  end
end
