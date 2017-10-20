# == Schema Information
#
# Table name: recipe_ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  quantity   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           default(""), not null
#  match      :integer          default("none"), not null
#

require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
