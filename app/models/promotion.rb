require 'TrialPromotion'
require 'InfluencerCouponPromotion'
class PromotionUsedError < StandardError; end
class Promotion < ApplicationRecord
  validates_presence_of :info, :for, :_type
  # validate :unique_action

  # def unique_action
  #   promos = Promotion.where("promotions.info ->> 'action' = ?", info['action'])
  #   if promos.count > 0
  #     errors.add(:info_action, "taken")
  #   end
  # end

  enum _type: [:system, :user]
  enum for: [:subscription]

  def applied_for?(user)
    user.user_promotions.where(promotion: self).count > 0
  end

  def self.of_action(action)
    klass = UserPromotion.promotion_for(action)
    klass.db_promotion
  end

  def apply_to(user)
    user_promo = UserPromotion.create({
      user: user,
      promotion: self
    })
    if user_promo.persisted?
      user_promo.implement
    elsif user_promo.errors.details[:promotion][0][:error] == :taken
      raise PromotionUsedError.new
    else
      user_promo.save!
    end
      
  end
end
