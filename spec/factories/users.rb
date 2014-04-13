# Read about factories at https://github.com/thoughtbot/factory_girl
# Read about Faker at https://github.com/stympy/faker

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    factory :admin do
      admin true
    end
  end
end
