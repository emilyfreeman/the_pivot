class Store < ActiveRecord::Base
  has_many :users
  # has_many :user_stores
  # has_many :users, through: :user_stores
  has_many :items

  def categories(store)
    Category.joins(:items).where(items: { store_id: store.id }).pluck(:name).uniq
  end
end
