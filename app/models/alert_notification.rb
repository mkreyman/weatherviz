require 'twilio-ruby'

class AlertNotification

  @account_sid   = ''
  @auth_token    = ''
  @twilio_number = ''

    if Rails.env.test? || Rails.env.development?
      @account_sid   = ENV['TWILIO_TEST_SID']
      @auth_token    = ENV['TWILIO_TEST_TOKEN']
      @twilio_number = ENV['TWILIO_TEST_FROM_NUMBER']
    else
      @account_sid   = ENV['TWILIO_ACCOUNT_SID']
      @auth_token    = ENV['TWILIO_AUTH_TOKEN']
      @twilio_number = ENV['TWILIO_FROM_NUMBER']
    end

  @client = Twilio::REST::Client.new @account_sid, @auth_token

byebug
  def send_alert(alert, weather_report)
    alert_messages = alert.messages(weather_report)
    alert_types = alert.alert_types
    message = "#{alert.alert_name}: #{alert_messages.join("\n")}"
    if alert_messages.any?
      AlertLog.create(alerts_id: alert.id,
                      sent_at: Time.zone.now,
                      alert_message: alert_messages.join("\n"),
                      alert_message_types: alert_types.join(" "))
      send_sms(alert_types[:sms], message)
      send_email(alert_types[:email], message)
    end
  end

  def send_sms(sms_number, message)
    if sms_number
      @client.account.messages.create(
          :from => @twilio_number,
          :to => sms_number,
          :body => message
      )
    end
  end

  def send_email(email, message)
    if email
      # Send email to email address
    end
  end

end