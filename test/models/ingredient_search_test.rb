# == Schema Information
#
# Table name: ingredient_searches
#
#  id         :integer          not null, primary key
#  search     :string           not null
#  results    :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class IngredientSearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
