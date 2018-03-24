class ChangeOrderIngredientColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :ingredient_id, :integer, null: true
  end
end
