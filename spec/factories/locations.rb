# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
