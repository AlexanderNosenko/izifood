# == Schema Information
#
# Table name: ingredient_translations
#
#  id            :integer          not null, primary key
#  ingredient_id :integer          not null
#  label         :string           not null
#  language      :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class IngredientTranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
