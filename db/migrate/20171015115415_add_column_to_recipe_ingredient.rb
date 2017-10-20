class AddColumnToRecipeIngredient < ActiveRecord::Migration[5.1]
  def change
  	add_column :recipe_ingredients, :match, :integer, default: 0, null: false
  end
end
