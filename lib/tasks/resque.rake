require 'resque/tasks'
require 'resque/scheduler/tasks'

Resque.logger.level = Logger::DEBUG

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

task "resque:scheduler_setup" => :environment

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"