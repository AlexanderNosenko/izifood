# == Schema Information
#
# Table name: menu_recipes
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MenuRecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
