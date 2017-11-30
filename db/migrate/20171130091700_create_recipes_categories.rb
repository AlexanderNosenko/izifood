class CreateRecipesCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes_categories do |t|
      t.belongs_to :recipe, null: false, index: true
      t.belongs_to :category, null: false, index: true

      t.timestamps
    end
  end
end
