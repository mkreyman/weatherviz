# config/initializers/geocoder.rb
Geocoder.configure(

    # geocoding service (see below for supported options):
    :lookup => :google,

    # IP address geocoding service (see below for supported options):
    :ip_lookup => :freegeoip,

    # to use an API key:
    # :api_key => "...",

    # geocoding service request timeout, in seconds (default 3):
    :timeout => 5,

    # set default units to kilometers:
    :units => :mi,

    # caching (see below for details):
    #:cache => Redis.new,
    #:cache_prefix => "..."

)

Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
    "Arvada", [
    {
        'latitude'     => 39.800057,
        'longitude'    => -105.089911,
        'address'      => 'Arvada, CO, USA',
        'state'        => 'Colorado',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "New York, NY", [
    {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "Denver, CO", [
    {
        'latitude'     => 39.737567,
        'longitude'    => -104.9847179,
        'address'      => 'Denver, CO, USA',
        'state'        => 'Colorado',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "Boulder, CO", [
    {
        'latitude'     => 40.0149856,
        'longitude'    => -105.2705456,
        'address'      => 'Boulder, CO, USA',
        'state'        => 'Colorado',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "Commerce City, CO", [
    {
        'latitude'     => 39.8083196,
        'longitude'    => -104.9338675,
        'address'      => 'Commerce City, CO, USA',
        'state'        => 'Colorado',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "Moscow, ID", [
    {
        'latitude'     => 39.8083196,
        'longitude'    => -104.9338675,
        'address'      => 'Moscow, ID, USA',
        'state'        => 'Idaho',
        'state_code'   => 'ID',
        'country'      => 'United States',
        'country_code' => 'US'
    }
]
)

Geocoder::Lookup::Test.add_stub(
    "Moscow, Russia", [
    {
        'latitude'     => 55.755826,
        'longitude'    => 37.6173,
        'address'      => 'Moscow, Russia',
        'country'      => 'Russia',
        'country_code' => 'RU'
    }
]
)

Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
    [
        {
            'latitude'     => 39.800057,
            'longitude'    => -105.089911,
            'address'      => 'Arvada, CO, USA',
            'state'        => 'Colorado',
            'state_code'   => 'CO',
            'country'      => 'United States',
            'country_code' => 'US'
        }
    ]
)