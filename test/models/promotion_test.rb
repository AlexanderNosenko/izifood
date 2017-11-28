require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  setup do
    @user = user = FactoryBot::create(:user)
  end

  test "should assign trial promotion for user" do
    init_count = UserPromotion.count
    init_count_payments = Payment.count

    assert_equal false, @user.active_member?

    assert @user.give_trial_promo!
 
    assert_equal init_count + 1, UserPromotion.count
    assert_equal true, @user.active_member?

    assert_equal init_count_payments + 1, Payment.count
  end
end
