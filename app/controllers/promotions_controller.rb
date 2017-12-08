class PromotionsController < ApplicationController
  skip_before_action :check_for_membership!
  
  def use_promo
    promotion = Promotion.find_by("info ->> 'simple_id' = ? ", params[:id])

    if promotion
      if current_user
        apply_promo(promotion)
        redirect_to recipes_path
      else
        render :register_with_promo, layout: false
      end
    else
      render :promotion_not_found, layout: false
    end
  end

  private

  def apply_promo(promotion)
    begin
      promotion.apply_to(current_user)
      flash[:success] = "1 free month added!"
    rescue PromotionUsedError
      flash[:notice] = "You have already used this type of promo!"
    rescue ActiveRecord::RecordInvalid # todo is it right place??
      flash[:error] = "Unnowed error"
    end
  end

  # def promo_params
  #   params.require(:id)
  # end
end
