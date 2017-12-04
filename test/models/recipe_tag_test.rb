# == Schema Information
#
# Table name: recipe_tags
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  order      :integer          default(0)
#  _type      :integer          default("category"), not null
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RecipeTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
