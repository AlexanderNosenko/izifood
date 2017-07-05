class ChangeColumnsTypes < ActiveRecord::Migration[5.1]
  def change
  	change_column :recipes, :r_type, 'integer USING r_type::integer', default: 0, index: true, null: false
  	change_column :recipes, :prep_time, 'integer USING prep_time::integer', default: 0, index: true, null: false
  	change_column :recipes, :prep_type, 'integer USING prep_type::integer', default: 0, index: true, null: false
  	change_column :recipes, :cost, 'integer USING cost::integer', default: 0, index: true, null: false
  	change_column :recipes, :calories, 'integer USING calories::integer', default: 0, index: true, null: false
  	change_column :recipes, :portion_size, 'integer USING portion_size::integer', default: 0, index: true, null: false
  	change_column :recipes, :main_ingredient, 'integer USING main_ingredient::integer', default: 0, index: true, null: false
  	change_column :recipes, :cuisine, 'integer USING cuisine::integer', default: 0, index: true, null: false
  end
end
