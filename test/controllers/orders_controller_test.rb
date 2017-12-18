require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest

  setup do
    host! "izifood.local"
    @user = FactoryBot::create(:user_with_membership)
    @recipe = FactoryBot::create(:recipe)

    sign_in @user
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end
end
