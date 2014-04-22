require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir  = Rails.root.join("spec", "vcr")
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<OpenWeatherMapAPIKey>') { ENV['OPENWEATHER_APPID'] }
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
end