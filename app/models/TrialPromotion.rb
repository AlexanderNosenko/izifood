class TrialPromotion
  # DB_ACTION_STRING = 'trial'
  
  def initialize(user_promotion)
    @user_promotion = user_promotion  
  end
  
  def self.db_promotion
    Promotion.find_by!("info ->> 'action' = ?", 'trial')
  end

  def go
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