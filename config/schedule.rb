app_dir = "/home/alexandr/Work/Sites/izifood_project/izifood"
set :output, "#{app_dir}/log/crons.log"

every ENV.fetch('CHECK_DILEVERY_SLOTS_FREQUENCY', 3).hours do
  runner "DeliverySlot.update_slots"
end

every 1.day do
  command "backup perform -t db_backup"
end