class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i(edit update)

  def index
  end

  def new
    prepare_slots
    @delivery = Delivery.new({ order_id: params[:order_id] })
    @delivery_adress = current_user.default_address
  end

  def create
    # flash = {}
    delivery = Delivery.new(prepared_params)

    if delivery.save
      flash[:info] = 'Delivery is set.'
      redirect_to recipes_path
    else
      flash[:error] = "Error occured!"
      redirect_to new_order_delivery_path(params[:order_id])
    end
  end

  def edit
    current_user.active_member?
    prepare_slots
    @delivery_adress = @delivery.address
  end

  def update
    if @delivery.update(prepared_params)
      flash[:info] = 'Delivery is updated!'
      redirect_to recipes_path
    else
      flash[:error] = "Unnown error occured"
      redirect_to edit_order_delivery_path(params[:order_id], params[:id])
    end
  end

  private
  
  def set_delivery
    @delivery = current_user.deliveries.find_by!(id: params[:id], order_id: params[:order_id])
  end

  def prepare_slots
    slots = DeliverySlot.fresh_for(:tesco)

    if slots.any?
      @delivery_slots = slots.first.content_html      
    else
      job_ids = DeliverySlot.update_slots
      @job_id = job_ids[:tesco]
      flash[:info] = 'We are checking fot available slots'
    end
  end
  
  def prepared_params
    times = delivery_params[:deliver_on].scan(/\d\d:\d\d/)
    adress = DeliveryAddress.find_by(id: delivery_params[:address_id].to_i)
    flash[:error] =  "Please fill in adress" if adress.nil?

    {
      deliver_on: DateTime.parse(delivery_params[:deliver_on]),
      time_from: times[0],
      time_to: times[1],
      cost_value: delivery_params[:cost_value],
      cost_currency: delivery_params[:cost_currency],
      order_id: params[:order_id],
      address: adress
    }
  end

  def delivery_attributes
    [
      :deliver_on,
      :time_from,
      :time_to,
      :cost_currency,
      :cost_value,
      :address_id
      # :order_id
    ]
  end

  def delivery_params
    params.require(:delivery).permit(delivery_attributes)  
  end
  
end
