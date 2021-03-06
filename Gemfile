source 'https://rubygems.org'
ruby "2.4.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgres as the database for Active Record
gem "pg"
# Pictures uploader
gem "carrierwave", :github => "carrierwaveuploader/carrierwave"
# Use Puma as the app server
gem 'puma'
# Production
gem 'puma_worker_killer'
# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'redis-namespace'
#Background jobs
gem 'sidekiq'
gem 'sidekiq-status'
gem 'sidekiq-middleware'
# Parsing tools
gem 'selenium-webdriver'
gem 'headless'
gem 'rest-client'
# Cron jobs
gem 'whenever', require: false


# Authorization
gem 'devise'
gem 'omniauth-facebook'
# Pagination
# gem 'kaminari'
gem 'will_paginate', '>= 3.1'
# Admin panel
gem "administrate"


# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# Styles
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem "font-awesome-rails"
gem 'roboto', '~> 0.2.0'
# Beautiful flashes
gem 'toastr-rails'


# Usefull tools
# Easy ENV_VARs
gem "figaro"
# Schema in models
gem 'annotate', git: 'https://github.com/ctran/annotate_models.git', require: false
# Structure apps seed under db/seeds/*
gem 'seedbank'
# Profiler
gem 'ruby-prof'
gem 'rails-perftest'


# Backups
# gem 'backup',   require: false
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'active_model_serializers'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Easy fake data
  gem 'faker'
  gem 'factory_bot'


  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  # Test runner
  gem 'minitest-rails'
  # Customizable Minitest output formats
  gem 'minitest-reporters'
  # Minitest-compatible test helpers for rails
  gem 'shoulda'


  # Dev & Deploy tools
  # Detect dead routes
  gem 'traceroute'

  gem 'better_errors'
  gem "binding_of_caller"
  gem 'capistrano', require: false#, '3.8.2'
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-postgresql', '~> 4.2.0' 
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'

end

group :production do
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
