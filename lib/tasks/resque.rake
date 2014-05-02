require 'resque/tasks'
require 'resque_scheduler/tasks'

Resque.logger.level = Logger::DEBUG

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

task "resque:scheduler_setup" => :environment