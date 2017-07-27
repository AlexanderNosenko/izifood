class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :menus
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def current_menu
  	if menus.count == 0
  	  Menu.create_first_menu_for(self)
  	else
	  Menu.current_menu(menus)
  	end
  end

  def menus_with_recipes
  	menus.includes(:recipes)
  end
end
