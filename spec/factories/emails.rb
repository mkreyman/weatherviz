# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    address "MyString"
    token "MyString"
    verified false
  end
end
