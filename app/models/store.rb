class Store < ActiveRecord::Base
  belongs_to :user
  has_many :user_stores
  has_many :users, through: :user_stores
  has_many :items
end
