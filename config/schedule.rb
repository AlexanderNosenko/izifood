set :output, "log/crons.log"

every ENV.fetch('CHECK_DILEVERY_SLOTS_FREQUENCY', 1).hours do
  rake "utils:update_delivery_slots"
end

every ENV.fetch('DELIVERY_SLOT_FREQUENCY', 1).hours do
  rake "utils:update_order_delivery_statuses"
end

every 1.day do
  command "backup perform -t db_backup"
end

every 1.day do
  command "sync; echo 1 > /proc/sys/vm/drop_caches"
end