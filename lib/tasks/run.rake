task run: :environment do
  if %x(redis-cli ping).match?("PONG")
    Rails.logger.info "Redis server already running"
  else
    system("redis-server --daemonize yes")
    Rails.logger.info "Redis server started"
  end


  system("bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml")
  Rails.logger.info "Sidekiq started as a daemon"
  Rails.logger.info "Starting Rails server..."
  system("rails s")
end
