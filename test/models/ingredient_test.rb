# == Schema Information
#
# Table name: ingredients
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  price_piece  :float            default(-1.0), not null
#  price_volume :float            default(-1.0)
#  quantifier   :string           default("-kg"), not null
#  min_amount   :string           not null
#  image        :string
#  tesco_id     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
