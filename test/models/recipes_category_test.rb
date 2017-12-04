# == Schema Information
#
# Table name: recipes_categories
#
#  id          :integer          not null, primary key
#  recipe_id   :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RecipesCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
