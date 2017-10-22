# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
gem install backup

backup generate:model --trigger=db_backup --databases='postgresql' --storages='scp' --compressor='gzip' --notifiers='mail'
foreman start -f Procfile
whenever --update-crontab

gem install bundler

sudo apt-get install postgresql postgresql-contrib postgresql-9.5 libpq-dev

sudo apt-get install redis-server
sudo systemctl restart redis-server.service
sudo systemctl enable redis-server.service

gem install selenium-webdriver