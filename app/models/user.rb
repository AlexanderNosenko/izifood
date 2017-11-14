# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :menus, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, through: :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  alias_attribute :addresses, :delivery_addresses

  def current_menu
  	if menus.count == 0
  	  Menu.create_first_menu_for(self)
  	else
	    menus.find_by(main: true)#TODO change name column
      # Menu.current_menu(menus)
  	end
  end
  
  def default_address
    delivery_addresses.find_or_initialize_by(default: true)
  end

  def menus_with_recipes
  	menus.includes(:recipes).order(created_at: :asc)
  end
end
