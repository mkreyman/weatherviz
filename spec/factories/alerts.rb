# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    alert_name "MyString"
    by_email false
    by_sms false
    email "MyString"
    sms "MyString"
    email_verified false
    phone_verified false
    active false
  end
end
