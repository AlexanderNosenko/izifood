class CreateRecipeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_tags do |t|
      t.string :title, null: false
      t.integer :_type, null: false, default: 0

      t.timestamps
    end
    
    add_index :recipe_tags, [:title, :_type], unique: true
  end
end
