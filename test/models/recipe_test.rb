# == Schema Information
#
# Table name: recipes
#
#  id              :integer          not null, primary key
#  title           :string           not null
#  images          :string           default([]), not null, is an Array
#  description     :text             default([]), not null, is an Array
#  desc_images     :string           default([]), is an Array
#  r_type          :integer          default("Inne"), not null
#  prep_time       :integer          default("Inne"), not null
#  prep_type       :integer          default("Inne"), not null
#  cost            :integer          default("Inne"), not null
#  calories        :integer          default("Inne"), not null
#  portion_size    :integer          default("Inne"), not null
#  main_ingredient :integer          default("Inne"), not null
#  cuisine         :integer          default("Inna"), not null
#  veg             :boolean          default(FALSE), not null
#  grill           :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :integer          default("unchecked"), not null
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
