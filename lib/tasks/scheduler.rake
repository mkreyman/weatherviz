# https://devcenter.heroku.com/articles/scheduler
desc "This task is called by the Heroku scheduler add-on"
task :weather_report_worker => :environment do
  puts "Updating weather reports for all locations with alerts..."
  WeatherReportWorker.perform
  puts "done."
end