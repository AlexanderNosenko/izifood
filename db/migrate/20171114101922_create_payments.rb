class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false, precision: 5, scale: 2
      t.belongs_to :user, foreign_key: true, null: false, index: true
      t.integer :_type, null: false, index: true, default: 0
      t.integer :status, null: false, index: true, default: 0
      t.jsonb :info, null: false, index: true, default: {}

      t.timestamps
    end
  end
end
