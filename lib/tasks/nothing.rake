namespace :db do
  desc "Backup database with backup gem"
  task :backup do
    sh "backup perform -t db_backup"
  end
end
