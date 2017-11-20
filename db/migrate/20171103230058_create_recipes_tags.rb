class CreateRecipesTags < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes_tags do |t|
      t.belongs_to :recipe, null: false
      t.belongs_to :tag, null: false

      t.timestamps
    end
    add_index :recipe_tags, [:recipe, :tag], unique: true
  end
end
