class CreateIngredientTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_translations do |t|
      t.belongs_to :ingredient, index: true, null: false
      t.string :label, null: false
      t.string :language, maximum: 10, null: false

      t.timestamps
    end
  end
end
