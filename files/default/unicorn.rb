worker_processes ENV["UNICORN_COUNT"] && ENV["UNICORN_COUNT"].to_i || 6
timeout ENV["UNICORN_TIMEOUT"] && ENV["UNICORN_TIMEOUT"].to_i || 120
stderr_path ENV["UNICORN_LOG"] || "/usr/share/foreman/log/unicorn.log"
stdout_path ENV["UNICORN_LOG"] || "/usr/share/foreman/log/unicorn.log"
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end
  sleep 1
end

after_fork do |server, worker|
  Rails.cache.reset

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

end
