# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "izifood.pl"
set :repo_url, "git@github.com:AlexandrNosenko/izifood.git"
set :branch, 'master'
set :rvm_ruby_version, "2.3.1@izifood"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/izifood_app/"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy #:remote_cache
set :ssh_options, { :forward_agent => true }#, keys: %w(~/.ssh/id_rsa.pub)
set :pty, true
set :use_sudo, false
set :stage, :production

#Puma config
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty #:airbrussh
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end
#   before :start, :make_dirs
# end

namespace :deploy do
  # desc "Make sure local git is in sync with remote."
  # task :check_revision do
  #   on roles(:app) do
  #     unless `git rev-parse HEAD` == `git rev-parse origin/master`
  #       puts "WARNING: HEAD is not the same as origin/master"
  #       puts "Run `git push` to sync changes."
  #       exit
  #     end
  #   end
  # end

  # desc 'Initial Deploy'
  # task :initial do
  #   on roles(:app) do
  #     sudo "ln -nfs '#{shared_path}config/config/nginx.conf' '/etc/nginx/sites-enabled/izifood_app'"
  #     sudo "service nginx restart"

  #     before 'deploy:restart', 'puma:start'
  #     invoke 'deploy'
  #   end
  # end
  # task :nginx_config do
  # 	on roles(:app) do
  #     sudo "ln -nfs '#{shared_path}/config/nginx.conf' '/etc/nginx/sites-enabled/izifood_app'"
  #     sudo "service nginx restart"
  #   end  	
  # end
  # before 'puma:start', 'deploy:nginx_config'
  before 'deploy:restart', 'puma:start'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  # before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma_pid