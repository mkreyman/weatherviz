class User < ActiveRecord::Base
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

end
