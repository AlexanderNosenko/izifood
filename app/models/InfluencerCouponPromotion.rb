class InfluencerCouponPromotion
  DB_ACTION_STRING = 'influencer_coupon'
  
  def initialize(user_promotion)
    @user_promotion = user_promotion  
  end
  
  def self.db_promotion
    Promotion.where("info ->> 'action' = ?", self::DB_ACTION_STRING).first
  end

  def go
    current_month = Time.now.strftime('%m.%Y')

    @user_promotion.user.payments.create({
      amount: 0,
      _type: :subscription,
      status: :success,
      info: {
        "valid_until": 1.month.since.strftime("%Y-%m-%d"),
        "source": @user_promotion.promotion._type.to_s
      }
    })
  end
end