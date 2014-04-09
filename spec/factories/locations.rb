# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    city_id 1
    city "MyString"
    state "MyString"
    country "MyString"
    lat 1.5
    lon 1.5
  end
end
