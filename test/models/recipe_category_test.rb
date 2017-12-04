# == Schema Information
#
# Table name: recipe_categories
#
#  id         :integer          not null, primary key
#  order      :integer          default(0)
#  title      :string           not null
#  icon       :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RecipeCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
