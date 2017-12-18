# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  menu_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("ok"), not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do

    @user = FactoryBot::create(:user_with_membership)

    @order = FactoryBot::create(:order, user: @user)
    @address = FactoryBot::create(:delivery_address, user: @user)
    @delivery = FactoryBot::create(:delivery, order: @order, address: @address)

  end

  describe '#update_delivery_statuses' do
    
    context '[NO SCHEDULED DELIVERIES]' do
      
      should "not change statuses or orders" do

        status = @order.status

        Order.update_delivery_statuses

        assert_equal @order.status, status
      end

    end

    context '[1 SCHEDULED DELIVERIES]' do
      
      should "change statuses of orders" do
        @delivery.update_attribute(:deliver_on_from, @delivery.deliver_on_from.change(day: 1.days.ago.day))

        Order.update_delivery_statuses

        order = Order.find(@order.id)

        assert_equal order.status, "delivered"
      end

    end
  
  end

end
