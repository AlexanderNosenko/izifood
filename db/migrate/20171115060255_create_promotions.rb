class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.integer :_type, null: false, default: 0, index: true
      t.integer :for, null: false, default: 0, index: true
      t.jsonb :info, null: false, default: {}, index: true

      t.timestamps
    end
    # add_index :promotions, "(info->'action')", :name => 'index_promotions_on_info_action', unique: true
  end
end
