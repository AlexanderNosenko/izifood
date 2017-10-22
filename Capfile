# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/postgresql'

require "capistrano/scm/git"
# Include capistrano-rails
require 'capistrano/rails'

require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/rails/migrations'
require 'capistrano/rails/assets'
require 'capistrano/puma'
require 'capistrano/sidekiq'
require "whenever/capistrano"

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)
install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks
# install_plugin Capistrano::Puma::Monit  # if you need the monit tasks
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
