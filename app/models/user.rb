class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :user_stores
  has_many :stores, through: :user_stores

  validates :username, presence: true,
                     uniqueness: true

  enum role: %w(default business_admin platform_admin)
end
