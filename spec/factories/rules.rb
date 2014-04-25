# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    field "MyString"
    operation "MyString"
    value "MyString"
    triggered false
  end
end
