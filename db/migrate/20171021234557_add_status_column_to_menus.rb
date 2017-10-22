class AddStatusColumnToMenus < ActiveRecord::Migration[5.1]
  def change
    add_column :menus, :status, :integer, null: false, default: 0
  end
end
