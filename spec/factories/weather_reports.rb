# Read about factories at https://github.com/thoughtbot/factory_girl

=begin
FactoryGirl.define do
  factory :weather_report do
    time_received Time.now - 10.minutes.ago
    sunrise Time.now - 6.hours.ago
    sunset Time.now + 18.hours
    weather { Faker::Lorem.sentence(3) }
    weather_desc { Faker::Lorem.sentence }
    temp { Faker::Number.number(3) }
    temp_min { Faker::Number.number(3) }
    temp_max { Faker::Number.number(3) }
    pressure { Faker::Number.number(4) }
    humidity { Faker::Number.number(2) }
    wind_speed { Faker::Number.number(2) }
    wind_gust { Faker::Number.number(3) }
    wind_degree { Faker::Number.number(2) }
    clouds { Faker::Number.number(2) }
    rain_3h { Faker::Number.number(2) }
    snow_3h { Faker::Number.number(2) }
  end
end
=end
