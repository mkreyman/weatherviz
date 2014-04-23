$redis = Redis.new(:host => 'localhost', :port => 6379)
REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])