# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :decimal(5, 2)    not null
#  user_id    :integer          not null
#  _type      :integer          default("subscription"), not null
#  status     :integer          default("uncleared"), not null
#  info       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
