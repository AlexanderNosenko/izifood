namespace :utils do
  desc "Update delivery slots from tesco"
  task :update_delivery_slots => [:environment] do
    puts "rake: utils:update_delivery_slots invoked"
    DeliverySlot.update_slots
  end
end