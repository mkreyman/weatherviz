require 'spec_helper'

# Possible tests...
# Timecop gem
# Expect JSON.parse to have been called twice
# Timecop.travel(15.minutes.ago).do
#   WeatherFetcher.fetch(...)
# end
# WeatherFetcher.fetch(...)

# Expect JSON.parse to have been called once
# Timecop.travel(5.minutes.ago).do
#   WeatherFetcher.fetch(...)
# end
# WeatherFetcher.fetch(...)