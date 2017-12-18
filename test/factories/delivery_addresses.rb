# == Schema Information
#
# Table name: delivery_addresses
#
#  id          :integer          not null, primary key
#  title       :string           default("Home 1")
#  address     :string           not null
#  flat_number :string           not null
#  details     :jsonb            not null
#  default     :boolean          default(FALSE), not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :delivery_address do
    user
    default { true }
    title { "Something" }
    address { Faker::Address.street_address }
    flat_number { Faker::Number.between(1, 100) }
    details { {somet: "ass"} }
  end
end
