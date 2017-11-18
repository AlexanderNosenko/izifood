puts "== Importing promotions"

Promotion.destroy_all

Promotion.create({
  _type: :system, 
  for: :subscription, 
  info: {
    action: 'trial'
  }
})

Promotion.create({
  _type: :user, 
  for: :subscription, 
  info: {
    action: 'influencer_coupon'
  }
})

puts "#{Promotion.count} promotions created"