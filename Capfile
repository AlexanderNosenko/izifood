# Load DSL and set up stages
require "capistrano/setup"
# Include default deployment tasks
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
# Include capistrano-rails
require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/bundler'
# require "bundler/capistrano"
require 'capistrano/rails/migrations'
require 'capistrano/rails/assets'
require 'capistrano/puma'
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
