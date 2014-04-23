redis_url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/0/cache'
$redis = Redis.new(:url => redis_url)