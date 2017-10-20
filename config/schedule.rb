# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
app_dir = "/home/alexandr/Work/Sites/izifood_project/izifood"
set :output, "#{app_dir}/log/crons.log"
every 1.day do
  command "backup perform -t db_backup"
end
# Learn more: http://github.com/javan/whenever
