class DeliveriesController < ApplicationController
  def index
  end

  def new
    slots = DeliverySlot.fresh_for(:tesco)
    if slots.any?
      @delivery_slots = slots.first.content_html
      @delivery = Delivery.new({ order_id: params[:order_id] })
    else
      job_ids = DeliverySlot.update_slots
      @job_id = job_ids[:tesco]
      flash[:notice] = 'We are checking fot available slots'
    end
  end

  def create
    delivery = Delivery.new(prepared_params)

    if delivery.save
      redirect_to recipes_path, notice: 'Delivery is set.'
    else
      redirect_to new_order_delivery_path(params[:order_id]), notice: "Error Delivery is already set"
    end
  end

  private 

  def prepared_params
    times = delivery_params[:deliver_on].scan(/\d\d:\d\d/)
    
    {
      deliver_on: DateTime.parse(delivery_params[:deliver_on]),
      time_from: times[0],
      time_to: times[1],
      cost_value: delivery_params[:cost_value],
      cost_currency: delivery_params[:cost_currency],
      order_id: params[:order_id]
    }
  end

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
