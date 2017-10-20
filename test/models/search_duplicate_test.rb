# == Schema Information
#
# Table name: search_duplicates
#
#  id         :integer          not null, primary key
#  value      :string           not null
#  origin_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SearchDuplicateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
