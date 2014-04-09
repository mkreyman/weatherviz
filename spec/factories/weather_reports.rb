# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weather_report do
    time_received 1
    sunrise 1
    sunset 1
    weather "MyString"
    weather_desc "MyString"
    temp 1.5
    temp_min 1.5
    temp_max 1.5
    pressure 1
    humidity 1
    wind_speed 1.5
    wind_gust 1.5
    wind_degree 1
    clouds "MyString"
    rain_3h 1
    snow_3h 1
  end
end
