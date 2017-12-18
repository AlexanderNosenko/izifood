class RemoveRedundantDeliverOnFromTables < ActiveRecord::Migration[5.1]
  
  def up
    remove_column :orders, :deliver_on if column_exists?(:orders, :deliver_on)
    remove_column :menus, :deliver_on if column_exists?(:menus, :deliver_on)
  end

  def down;end

end
