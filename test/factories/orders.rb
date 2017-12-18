# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  menu_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("ok"), not null
#

FactoryBot.define do
  factory :order do
    user
    menu
    status { "ok" }
  end
end
