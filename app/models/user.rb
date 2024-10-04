require 'bcrypt'

class User < ApplicationRecord
  include ActiveModel::SecurePassword
  include BCrypt

  has_secure_password
  has_many :interactions

  enum :user_type, { :registered => 1, :administrator => 2, :super_user => 3 }

  validates :email, presence: true
  validates :password_digest, presence: true
  validates :password_confirmation, presence: true, on: :create

  validates_format_of :email,  with: URI::MailTo::EMAIL_REGEXP

  #after_validation { self.errors.messages.delete(:password_digest) }

end
