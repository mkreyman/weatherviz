# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    city { 'Arvada' }
    latitude { 39.800057 }
    longitude { -105.089911 }
    state { 'Colorado' }
    state_code { 'CO' }
    country { 'United States' }
    country_code { 'US' }
  end
end
