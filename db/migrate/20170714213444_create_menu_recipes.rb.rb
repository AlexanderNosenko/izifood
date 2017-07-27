class CreateMenuRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_recipes do |t|
      t.belongs_to :menu, index: true, foreign_key: true
      t.belongs_to :recipe, index: true, foreign_key: true

      t.timestamps
    end
  end
end
