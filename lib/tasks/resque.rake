require 'resque/tasks'
require 'resque_scheduler/tasks'

Resque.logger.level = Logger::DEBUG

task "resque:setup" => :environment