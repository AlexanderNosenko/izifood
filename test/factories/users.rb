# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  name                   :string
#  provider               :string
#  uid                    :string
#  confirmation_token     :string
#  unconfirmed_email      :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unlock_token           :string
#  locked_at              :datetime
#  failed_attempts        :integer          default(0), not null
#

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    password Faker::HarryPotter.house

    factory :user_with_membership do
      after(:create) do |user, evaluator|
        user.give_trial_promo!
      end
    end
  end
end
