# == Schema Information
#
# Table name: user_promotions
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  promotion_id :integer          not null
#  info         :jsonb            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class UserPromotionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
