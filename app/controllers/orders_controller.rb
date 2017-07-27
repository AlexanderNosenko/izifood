class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def create
  	vsdsdv	
  end

  def new
  	@order = current_user.current_menu.to_order  	
  end
end
