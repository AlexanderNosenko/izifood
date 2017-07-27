class OrdersController < ApplicationController
  def index
  end

  def create
  	vsdsdv	
  end

  def new
  	@order = current_user.current_menu.to_order  	
  end
end
