# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  title      :string
#  recurring  :boolean          default(FALSE)
#  main       :boolean          default(TRUE), not null
#  deliver_on :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0), not null
#

require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
