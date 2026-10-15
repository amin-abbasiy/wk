# namespace :db do
#   desc "Backup the database"
#   task :backup => :environment do
#     # Set the environment
#     env = ENV['RAILS_ENV'] || 'development'
#     # Set the backup directory
#     backup_dir = "#{Rails.root}/db/backup/#{env}"
#     # Create the backup directory if it doesn't exist
#     FileUtils.mkdir_p backup_dir
#     # Set the backup file name
#     backup_file = "#{backup_dir}/#{Time.now.strftime('%Y%m%d%H%M%S')}.sqlite"
#     # Backup the database
#     %w(development.sqlite3 development.sqlite3-shm development.sqlite3-wal).each do |file|
#       FileUtils.cp "#{Rails.root}/storage/#{file}", backup_dir
#     end
#   end
# end