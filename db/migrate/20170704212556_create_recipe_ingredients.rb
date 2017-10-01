class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|

      t.belongs_to :recipe, index: true
      t.string :title, index: true, null: false
      t.string :quantity, null: false

      t.timestamps
    end
  end
end
