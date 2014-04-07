class User < ActiveRecord::Base
  has_secure_password(validations: false)

  validates_confirmation_of :password,
    if: lambda { |user| !user.omniauth? && user.password.present? }
  validates_presence_of :password, :on => :create,
    if: lambda { |user| !user.omniauth? }
  validates_presence_of :password_confirmation, :on => :create,
    if: lambda { |user| !user.omniauth? && user.password.present? }
end
