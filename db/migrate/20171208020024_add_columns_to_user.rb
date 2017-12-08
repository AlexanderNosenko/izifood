class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change

    #Avatar
    add_column :users, :avatar, :string

    #Auth
    add_column :users, :name, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    ## Confirmable  
    add_column :users, :confirmation_token, :string
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    
    ## Lockable
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
    add_column :users, :failed_attempts, :integer, default: 0, null: false

  end
end
