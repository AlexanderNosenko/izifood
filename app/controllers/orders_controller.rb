class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    orders = current_user.orders
                         .includes(:delivery)
                         .order('deliveries.id ASC')
                         .page(params[:page])
                         .per(4)

    render locals: {
      orders: orders
    }
  end

  def new
    @order = current_user.current_menu.to_order
  end

  def edit
    @order = Order.find(params[:id])

    @order.ok! if params[:attention]
  end
  
  def update
    @order = Order.find(params[:id])

    if @order.update(order_items_attributes: order_items_params)
      @order.remove_not_mentioned!(order_items_params)
      redirect_to recipes_path, success: 'Order is saved.'
    else
      flash[:error] = 'Please correct your order.'
      render :edit
    end
  end

  def create
  	menu  = current_user.current_menu

    @order = Order.new({
  	  user_id: current_user.id,
  	  menu_id: menu.id,
  	  order_items_attributes: order_items_params
  	})

    if @order.save
      redirect_to new_order_delivery_path(@order), success: 'Order was successfully created.'
    else
      flash[:error] = 'Please correct your order.'
      render :new
    end

  end

  def job_status
    render json: Sidekiq::Status::status(params[:job_id])
  end

  private 
  
  def order_item_attributes
    [ 
      :id,
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
