class Alert < ActiveRecord::Base
  belongs_to :user
  has_many :rules, :dependent => :destroy
  has_many :alert_logs, :dependent => :destroy

  def self.per_page
    10
  end

  def messages(weather_report)
    rules.map do |rule|
      rule.message(weather_report)
    end.compact
  end

  def alert_types
    @types = Hash.new
    if self.by_email.present? && !self.email.blank?
      @types[:email] = self.email
    end
    if self.by_sms.present? && !self.sms.blank?
      @types[:sms] = self.sms
    end
    @types
  end

  def city
    Location.find(self.location_id).city
  end

  def user
    User.find(self.user_id)
  end

end
