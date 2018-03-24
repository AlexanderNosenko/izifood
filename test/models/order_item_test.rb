# == Schema Information
#
# Table name: order_items
#
#  id                   :integer          not null, primary key
#  recipe_ingredient_id :integer          not null
#  order_id             :integer          not null
#  ingredient_id        :integer
#  quantity             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
