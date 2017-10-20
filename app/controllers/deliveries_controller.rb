class DeliveriesController < ApplicationController
  def index
  end

  def new
  end

  def create
  	times = delivery_params[:deliver_on].scan(/\d\d:\d\d/)

    delivery = Delivery.new({
      deliver_on: DateTime.parse(delivery_params[:deliver_on]),
      time_from: times[0],
      time_to: times[1],
      cost_value: delivery_params[:cost_value],
      cost_currency: delivery_params[:cost_currency],
      order_id: params[:order_id]
    })

    if delivery.save
      redirect_to recipes_path, notice: 'Order is places.'
    else
      redirect_to order_delivery_path(params[:order_id])
    end
  end

  private 
  def delivery_attributes
    [
      :deliver_on,
      :time_from,
      :time_to,
      :cost_currency,
      :cost_value,
      :order_id
    ]
  end

  def delivery_params
    params.require(:delivery).permit(delivery_attributes)  
  end
  
end
