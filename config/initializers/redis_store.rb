redis_url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/0/cache'
$redis = Redis.new(:url => redis_url)
WeatherViz::Application.config.cache_store = :redis_store, redis_url
WeatherViz::Application.config.action_dispatch.rack_cache = :redis_store, redis_url