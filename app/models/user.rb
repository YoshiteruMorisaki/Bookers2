class User < ApplicationRecord

  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy

  has_many :books, dependent: :destroy


  validates :email_address, presence: true
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }, allow_blank: true
  has_secure_password
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
end
