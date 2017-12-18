namespace :utils do
  desc "Update order delivery statuses"
  task :update_order_delivery_statuses => [:environment] do
    puts "rake: utils:update_order_delivery_statuses invoked"
    Order.update_delivery_statuses
  end
end