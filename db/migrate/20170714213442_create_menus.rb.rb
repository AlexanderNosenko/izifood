class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :title, index: true
      t.boolean :recurring, index: true, default: false
      t.boolean :main, null: false, default: true, index: true
      t.datetime :deliver_on, index: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
