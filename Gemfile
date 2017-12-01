source 'https://rubygems.org'
ruby "2.4.2"

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
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#Easy ENV_VARs
gem "figaro"
#Schema in models
gem 'annotate', git: 'https://github.com/ctran/annotate_models.git', require: false
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
#Styles
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'roboto', '~> 0.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'active_model_serializers'
# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'redis-namespace'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Authorization
gem 'devise'
# Pagination
# gem 'kaminari'
gem 'will_paginate', '>= 3.1'
# Admin panel
gem "administrate"
#Background jobs
gem 'sidekiq'
gem 'sidekiq-status'
gem 'sidekiq-middleware'

gem 'selenium-webdriver'
gem 'headless'
gem 'rest-client'

# Structure apps seed under db/seeds/*
gem 'seedbank'

# Backups
gem 'whenever', require: false
# gem 'backup',   require: false

# Profiler
gem 'ruby-prof'
gem 'rails-perftest'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot'
  
  # Easy fake data
  gem 'faker'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'capistrano', require: false#, '3.8.2'
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-postgresql', '~> 4.2.0' 
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'

  # gem 'minitest-rails'
  # Customizable Minitest output formats
  # gem 'minitest-reporters'
  # Minitest-compatible test helpers for rails
  # gem 'shoulda'



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