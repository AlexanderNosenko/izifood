class DeliveryAddressesController < ApplicationController
  
  def create
    @delivery_adress = current_user.addresses.new(address_params)
    
    if @delivery_adress.save
      flash[:success] = "Address saved"
    else
      flash[:error] = "Error saving Address"
    end

    respond_to do |format|
      # format.js { render '_form' }
      format.js { render '_form_results' }
    end

  end

  def update
    @delivery_adress = current_user.addresses.find(params[:id])
    
    if @delivery_adress.update(address_params)
      flash[:success] = "Address saved"
    else
      flash[:error] = "Error saving Address"
    end

    respond_to do |format|
      format.js { render '_form_results' }
    end

  end

  private
  def address_params
    params.require(:delivery_address).permit(:address, :flat_number, :details, :default)
  end
end
