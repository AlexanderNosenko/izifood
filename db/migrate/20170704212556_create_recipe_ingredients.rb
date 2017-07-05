class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|

      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe, index: true
      t.string :quantity, null: false

      t.timestamps
    end
  end
end
