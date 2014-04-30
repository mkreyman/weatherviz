class Alert < ActiveRecord::Base
  has_many :rules, :dependent => :destroy
  belongs_to :user
  has_many :alert_logs, :dependent => :destroy

  def messages(weather_report)
    rules.map do |rule|
      rule.message(weather_report)
    end.compact
  end

  def alert_types(alert)
    @types = Hash.new
    if alert.by_email.present? && !alert.email.blank?
      @types[:email] = alert.email
    end
    if alert.by_sms.present? && !alert.sms.blank?
      @types[:sms] = alert.sms
    end
    @types
  end

  def location
    Location.find(self.location_id).city
  end
end
