class User < ApplicationRecord
  has_and_belongs_to_many :skills

  validates :first_name, :last_name, length: { in: 2..20 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :contact, uniqueness: true
end
