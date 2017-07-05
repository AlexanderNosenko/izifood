class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
	  # enable_extension "hstore"
      # t.hstore :ingredients, null: false

   	  t.string :title, null: false
      t.string :images, array: true, default: [], null: false
      t.text :description, array: true, default: [], null: false      
	  t.string :desc_images, array: true, default: []      
   	  t.string :r_type, null: false, index: true
   	  t.string :prep_time, null: false, index: true
   	  t.string :prep_type, null: false, index: true
   	  t.string :cost, null: false, index: true
   	  t.string :calories, null: false, index: true
   	  t.string :portion_size, null: false, index: true
   	  t.string :main_ingredient, null: false, index: true
   	  t.string :cuisine, null: false, index: true
      
      t.boolean :veg, default: false, index: true, null: false
      t.boolean :grill, default: false, index: true, null: false
   	  
      t.timestamps
    end
  end
end