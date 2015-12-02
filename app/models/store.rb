class Store < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :items
end
