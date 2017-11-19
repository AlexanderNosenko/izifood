class AccountsController < ApplicationController
  skip_before_action :check_for_membership!, only: %i(renew_membership use_membership_promo update_membership)

  def edit
    
  end

  def renew_membership
  end

  def update_membership
    payment = Payment.new_subcription_payment_for(current_user)
    redirect_to recipes_path if payment.save
  end
  
  def use_membership_promo
    if current_user.give_trial_promo!
      flash[:success] = "You have successly renews your membership"
      redirect_to recipes_path
    else
      flash[:error] = "Error occured"
  
      redirect_to renew_membership_path
    end
  end
end
