class Alert < ActiveRecord::Base
  has_many :rules, :dependent => :destroy
  belongs_to :user
end
