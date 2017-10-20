class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def create
  	@order = Order.new({
  	  user_id: current_user.id,
  	  menu_id: current_user.current_menu.id,
  	  order_items_attributes: order_items_params
  	})
    respond_to do |format|
      if @order.save
        # format.html { redirect_to new_order_path }
        format.html { redirect_to order_delivery_path(@order), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def delivery
    @delivery = Delivery.new({ order_id: params[:order_id] })
    @delivery_slots ||= DeliverySlot.for(:tesco).content_html
  end

  def delivery_create
    
  end

  def new
  	@order = current_user.current_menu.to_order
  end
  private 
  
  # def order_items
  # 	params[:order][:order_items].map { |order_item|
  # 	  next if order_item[:quantity].blank? || order_item[:ingredient_id].blank?
  # 	  OrderItem.new(order_item.permit(order_item_attributes))
  # 	}.reject { |i| i.nil? }
  # end
  
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
