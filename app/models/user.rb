class User < ActiveRecord::Base
  has_secure_password

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :orders

  has_many :user_stores
  has_many :stores, through: :user_stores

  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :username, presence: true,
                       uniqueness: true
end
