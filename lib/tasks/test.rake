namespace :db do
  task :backup do
	sh "backup perform -t db_backup"
  end
end
