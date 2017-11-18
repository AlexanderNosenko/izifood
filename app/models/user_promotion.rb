class UserPromotion < ApplicationRecord
  belongs_to :user
  belongs_to :promotion

  validates_uniqueness_of :promotion, scope: :user
  
  def implement
    klass = UserPromotion.promotion_for(promotion.info['action'])
    klass.new(self).go
  end

  def self.promotion_for(_name)
    #Todo safe eval or some shit like that
    case _name
    when 'trial'
      TrialPromotion
    when 'influencer_coupon'
      InfluencerCouponPromotion
    else
      raise StandardError.new("No handler for #{promotion.info['action']} promotion")
    end
  end

end
