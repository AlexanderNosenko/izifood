env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :output, "log/crons.log"

every ENV.fetch('CHECK_DILEVERY_SLOTS_FREQUENCY', 1).minutes do
  runner "DeliverySlot.update_slots"
end

every 1.day do
  command "backup perform -t db_backup"
end

# every 1.day do
#   command "rm -rf #{RAILS_ROOT}/tmp/cache"
# end