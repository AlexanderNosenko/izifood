# == Schema Information
#
# Table name: delivery_slots
#
#  id           :integer          not null, primary key
#  content_html :text             not null
#  vendor       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class DeliverySlotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
