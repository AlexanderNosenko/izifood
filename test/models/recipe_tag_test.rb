# == Schema Information
#
# Table name: recipe_tags
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  _type      :integer          default("category"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RecipeTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
