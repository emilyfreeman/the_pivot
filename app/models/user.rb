class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :stores, through: :store_users
  has_one :store

  validates :username, presence: true,
                     uniqueness: true

  enum role: %w(default business_admin platform_admin)
end
