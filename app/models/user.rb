class User < ApplicationRecord

  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true
  validates :name, length: { minimum: 2 }
  has_secure_password
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
