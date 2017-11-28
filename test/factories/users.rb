FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password Faker::HarryPotter.house
  end
end
