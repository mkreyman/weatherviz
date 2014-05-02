class AlertNotifier < ActionMailer::Base
  include SendGrid
  default from: "alerts@weatherviz.org"
  sendgrid_category :use_subject_lines

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_notifier.notify.subject
  #
  def notify(email, message)
    @email_address = email
    @alert_message = message

    mail :to => email, :subject => message
  end
end
