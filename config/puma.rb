root_dir = '/home/alexandr/Work/Sites/izifood_project/izifood'
directory root_dir
rackup "#{root_dir}/config.ru"

config_env = 'development'

environment config_env
# port        ENV.fetch("PORT") { 3000 }

tag ''

pidfile "#{root_dir}/tmp/pids/puma.pid"
state_path "#{root_dir}/tmp/pids/puma.state"
# stdout_redirect '/home/izifood_app/current/log/puma.error.log', '/home/izifood_app/current/log/puma.access.log', true

# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads 4,16

bind "unix://#{root_dir}/tmp/sockets/izifood.pl-puma.sock"

workers config_env == 'production' ? 3 : 0

restart_command 'bundle exec puma'

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
preload_app!

# If you are preloading your application and using Active Record, it's
# recommended that you close any connections to the database before workers
# are forked to prevent connection leakage.
#
before_fork do
  require 'puma_worker_killer'

  PumaWorkerKiller.enable_rolling_restart

  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted, this block will be run. If you are using the `preload_app!`
# option, you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, as Ruby
# cannot share connections between processes.
#
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = ""
end
