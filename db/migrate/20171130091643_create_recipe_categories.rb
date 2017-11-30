class CreateRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_categories do |t|
      t.integer :order, default: 0, index: true
      t.string :title, null: false, index: true
      t.string :icon
      t.belongs_to :parent, null: true, index: true

      t.timestamps
    end
  end
end
