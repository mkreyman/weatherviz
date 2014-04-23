redis_url = ENV['REDISTOGO_URL'] || "redis://localhost:6379/0/weatherviz"
WeatherViz::Application.config.cache_store = :redis_store, redis_url
WeatherViz:::Application.config.session_store :redis_store, redis_server: redis_url