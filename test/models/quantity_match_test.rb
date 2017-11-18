# == Schema Information
#
# Table name: quantity_matches
#
#  id         :integer          not null, primary key
#  key        :string
#  value      :string
#  quantifier :string
#  origin_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuantityMatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
