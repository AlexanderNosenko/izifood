# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  title      :string
#  recurring  :boolean          default(FALSE)
#  main       :boolean          default(TRUE), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0), not null
#

FactoryBot.define do
  factory :menu do
    title Faker::HarryPotter.house
    user
    main { false }
    recurring { false }
    status { 0 }
  end
end
