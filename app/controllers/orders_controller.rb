class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def edit
    @order = Order.find(params[:id])
  end
  
  def create
  	menu  = current_user.current_menu

    if menu.active?
      @order = Order.new({
    	  user_id: current_user.id,
    	  menu_id: menu.id,
    	  order_items_attributes: order_items_params
    	})

      if @order.save
        redirect_to new_order_delivery_path(@order), success: 'Order was successfully created.'
      else
        render :new
      end
    else
      redirect_to recipes_path, notice: 'Menu is already ordered, please edit the current one'
    end

  end

  def job_status
    render json: Sidekiq::Status::status(params[:job_id])
  end

  def new
  	@order = current_user.current_menu.to_order
  end

  private 
  
  def order_item_attributes
    [ 
      :recipe_ingredient_id, 
      :quantity, 
      :ingredient_id
   ]
  end

  def order_items_params
    params.require(:order).require(:order_items_attributes).map do |p|
      p.permit(order_item_attributes)
    end
  end

end
