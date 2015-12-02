class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_and_belongs_to_many :stores

  validates :username, presence: true,
                     uniqueness: true

  enum role: %w(default business_admin platform_admin)
end
