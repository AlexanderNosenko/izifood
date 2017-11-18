require 'test_helper'
require 'InfluencerCouponPromotion'

class InfluencerCouponPromotionTest < ActiveSupport::TestCase
  setup do
    @user = user = FactoryGirl::create(:user)
  end

  test "should create payment for the next month" do
    init_count = Payment.count

    assert @user.give_influencer_promo!
 
    assert_equal init_count + 1, Payment.count
    
    expected_info = {
      source: 'user', 
      valid_until: 1.month.since.strftime("%Y-%m-%d")
    }
    
    assert_equal expected_info.to_json, Payment.last.info.to_json.to_s
    Payment.last.destroy
  end
end
