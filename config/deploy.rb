# config valid only for current version of Capistrano
lock "3.10.0"

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
set :puma_workers,    3
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# Sidekiq config
set :sidekiq_default_hooks, true
set :sidekiq_pid, File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
set :sidekiq_env, fetch(:rails_env)
set :sidekiq_log, File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_role, :app
set :sidekiq_processes, 1
# :sidekiq_require => nil
# :sidekiq_config => nil # if you have a config/sidekiq.yml, do not forget to set this. 
# :sidekiq_queue => nil
# :sbunidekiq_service_name => "sidekiq_#{fetch(:application)}_#{fetch(:sidekiq_env)}"
# :sidekiq_cmd => "#{fetch(:bundle_cmd, "bundle")} exec sidekiq" # Only for capistrano2.5
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
set :linked_files, %w{config/secrets.yml config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle, public}

# Rake::Task["puma:start"].reenable
namespace :deploy do
  # desc "Fix deploy:puma:restart bug"
  # task :puma_restart_fix do
  #   on roles(:app) do 
  #     execute("cd #{current_path}; /usr/local/rvm/bin/rvm #{fetch(:rvm_ruby_version)} do bundle exec puma -C #{shared_path}/puma.rb --daemon")
  #   end
  # end

  # after 'puma:restart', 'deploy:puma_restart_fix'
  
  desc "Update crontab with whenever"
  task :update_cron do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
      end
    end
  end

  after :finishing, 'deploy:update_cron'
end