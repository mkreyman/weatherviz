require 'twilio-ruby'

class AlertNotification

  def send_alert(alert, weather_report)
    alert_messages = alert.messages(weather_report)
    alert_types = alert.alert_types
    message = "#{alert.alert_name}: #{alert_messages.join("\n")}"
    if alert_messages.any?
      AlertLog.create(alerts_id: alert.id,
                      sent_at: Time.zone.now,
                      alert_message: alert_messages.join("\n"),
                      alert_message_types: alert_types.values.join(" "))
      send_sms(alert_types[:sms], message)
      send_email(alert_types[:email], message)
    end
  end

  def send_sms(sms_number, message)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    from_number = ENV['TWILIO_FROM_NUMBER']
    client      = Twilio::REST::Client.new account_sid, auth_token
    if sms_number
      client.account.messages.create(
          :from => from_number,
          :to => sms_number,
          :body => message
      )
    end
  end

  def send_email(email, message)
    if email
      AlertNotifier.new.notify(email, message)
    end
  end

end