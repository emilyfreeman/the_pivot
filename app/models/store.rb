class Store < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :store_users
  has_many :items
end
