# == Schema Information
#
# Table name: delivery_addresses
#
#  id          :integer          not null, primary key
#  title       :string           default("Home 1")
#  address     :string           not null
#  flat_number :string           not null
#  details     :jsonb            not null
#  default     :boolean          default(FALSE), not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class DeliveryAddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
