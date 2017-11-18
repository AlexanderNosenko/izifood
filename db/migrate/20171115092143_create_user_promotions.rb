class CreateUserPromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_promotions do |t|
      t.belongs_to :user, foreign_key: true, null: false, index: true
      t.belongs_to :promotion, foreign_key: true, null: false, index: true
      t.jsonb :info, null: false, default: {}, index: true

      t.timestamps
    end
  end
end
