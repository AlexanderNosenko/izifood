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


FactoryBot.define do
  factory :recipe do
    title { Faker::Beer.name }
    images { [] }
    description { [] }
    desc_images { [] }
    r_type { 1 }
    prep_time { 2 }
    prep_type { 3 }
    calories { 1 }
    cost { 2 }
    portion_size { 2 }
    main_ingredient { 1 }
    cuisine { 1 }
    veg { 1 }
    grill { false }
    status { 0 }
  end
end
