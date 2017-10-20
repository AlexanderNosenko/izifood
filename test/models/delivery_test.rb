# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  deliver_on    :date             not null
#  cost_value    :decimal(5, 2)    not null
#  cost_currency :string           not null
#  time_from     :string           not null
#  time_to       :string           not null
#  order_id      :integer          not null
#

require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
