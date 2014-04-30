class AlertNotification

  def send_alert(alert, weather_report)
    @alert_messages = alert.messages(weather_report)
    alert_types = alert.alert_types
    if @alert_messages.any?
      AlertLog.create(sent_at: Time.zone.now, alert_message: @alert_messages.join("\n"), alert_message_types: alert_types.join(" "))
      send_sms(alert_types[:sms])
      send_email(alert_types[:email])
    end
  end

  def send_sms(sms_number)
    if sms_number
      # Send SMS to sms_number
    end
  end

  def send_email(email)
    if email
      # Send email to email address
    end
  end

end