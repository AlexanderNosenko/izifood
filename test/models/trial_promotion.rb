require 'test_helper'
require 'TrialPromotion'

class TrialPromotionTest < ActiveSupport::TestCase
  setup do
    @user = user = FactoryBot::create(:user)
  end

  test "should create payment for the next month" do
    init_count = Payment.count

    assert @user.give_trial_promo!
 
    assert_equal init_count + 1, Payment.count
    expected_info = {
      source: 'system', 
      valid_until: 1.month.since.strftime("%Y-%m-%d")
    }

    assert_equal expected_info.to_json, Payment.last.info.to_json.to_s
    Payment.last.destroy
  end
end