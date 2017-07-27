class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :menu, index: true, foreign_key: true
      t.datetime :deliver_on, index: true

      t.timestamps
    end
  end
end
