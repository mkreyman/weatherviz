require 'resque/tasks'
require 'resque_scheduler/tasks'

Resque.logger.level = Logger::DEBUG

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"