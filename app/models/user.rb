class User < ActiveRecord::Base
  has_many :alerts, :dependent => :destroy
  has_many :rules, :through => :alerts
  has_many :alert_logs, :through => :alerts
  has_many :emails, :dependent => :destroy
  has_secure_password(validations: false)

  validates_confirmation_of :password,
    if: lambda { |user| !user.omniauth? && user.password.present? }
  validates_presence_of :password, length: { minimum: 8 }, :on => :create,
    if: lambda { |user| !user.omniauth? }
  validates_presence_of :password_confirmation, :on => :create,
    if: lambda { |user| !user.omniauth? && user.password.present? }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  geocoded_by :ip_address
  after_validation :geocode, :if => lambda{ |obj| obj.ip_address_changed? }

  def self.per_page
    10
  end

  def needs_verification!
    self.update_attributes!(
        token: SecureRandom.urlsafe_base64,
        verified_email: false
    )
    UserNotifier.signed_up(self).deliver
  end

end
