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
  test "should return same id for a backgroud job" do
    job_ids = 4.times.map { DeliverySlot.update_slots[:tesco] }
    job_ids.each { |job_id| assert_equal job_ids[0], job_id }
  end
end
