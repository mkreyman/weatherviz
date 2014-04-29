json.array!(@alerts) do |alert|
  json.extract! alert, :id, :alert_name, :by_email, :by_sms, :email, :sms, :email_verified, :phone_verified, :active
  json.url alert_url(alert, format: :json)
end
