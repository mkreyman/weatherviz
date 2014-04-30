# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert_log do
    sent_at "2014-04-30 02:35:07"
    alert_message "MyText"
    alert_message_types "MyText"
    alert_id 1
  end
end
