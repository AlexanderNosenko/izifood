require 'test_helper'

class DeliveriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    host! "izifood.local"
    @user = FactoryBot::create(:user_with_membership)

    sign_in @user
  end

  describe '#create' do
    context '[CORRECT INPUT]' do
      should "create new delivery for order" do
        initial_deliveries = Delivery.count

        order = FactoryBot::create(:order, user: @user)
        address = FactoryBot::create(:delivery_address, user: @user)

        params = FactoryBot::attributes_for(:delivery, user_id: @user.id, address_id: address.id)

        params[:deliver_on] = "#{params[:deliver_on].strftime("%d-%m-%Y")} #{params[:time_from]} - #{params[:time_to]}"

        post order_delivery_index_path(order, params: {
            delivery: params
          })

        # p response.body[15000..30000]
        assert_redirected_to recipes_url

        assert_equal initial_deliveries + 1, Delivery.count
      end
    end
  end
end
