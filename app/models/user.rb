class User < ApplicationRecord
  validates :first_name, :last_name, length: { in: 2..20 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :contact, uniqueness: true
end
