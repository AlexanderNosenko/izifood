class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, :check_for_membership!, :setup_menus, only: %i(job_status)

  def index
    orders = current_user.orders
                         .includes(:delivery)
                         .order('deliveries.id ASC')
                         .paginate(:page => params[:page], :per_page => 6)

    render locals: {
      orders: orders
    }
  end

  def new
  # result = RubyProf.profile do
    @order = current_user.current_menu.to_order
    # render :new
  # end
  # printer = RubyProf::MultiPrinter.new(result)
  # printer.print(:path => "./public/profiler", :profile => "profile")
  end

  def edit
  # result = RubyProf.profile do
  
    @order = Order.find(params[:id])

    @order.ok! if params[:attention]
  #   render :edit
  # end
  # printer = RubyProf::MultiPrinter.new(result)
  # printer.print(:path => "./public/profiler", :profile => "profile")
  end
  
  def update
    @order = Order.find(params[:id])

    if @order.canceled?
      flash[:warning] = 'Order is already canceled.'
      redirect_to edit_order_path(@order)
    elsif @order.update(order_items_attributes: order_items_params)
      @order.remove_not_mentioned!(order_items_params)
      flash[:success] = 'Order is saved.'
      redirect_to edit_order_path(@order)
    else
      @errors = @order.errors.to_a.map { |text| [:error, text]}
      @errors = [[ :error, 'Please correct your order.']]
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
      flash[:success] = 'Order was successfully created.'
      redirect_to new_order_delivery_path(@order)
    else
      @errors = @order.errors.to_a.map { |text| [:error, text]}
      @errors.push([ :error, 'Please correct your order.'])
      render :new
    end

  end

  def cancel
    @order = Order.find(params[:id])
    
    if @order.update_attribute(:status, 'canceled')
      flash[:success] = "Order successfully canceled!"
    else
      flash[:error] = "Error occured!"
    end
  
    redirect_to orders_path
  end

  def job_status
    status = Sidekiq::Status::status(params[:job_id])
    DeliverySlots.clean_job_status_cache if status == 'completed'
    render json: status
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
