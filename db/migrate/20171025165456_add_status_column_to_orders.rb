class AddStatusColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :integer, null: false, default: 0
  end
end
