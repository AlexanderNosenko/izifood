namespace :db do
  namespace :test do
    task :prepare => :environment do
      puts 'asas'
      Rake::Task["db:seed"].invoke
    end
  end
end