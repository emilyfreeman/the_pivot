class Store < ActiveRecord::Base
  belongs_to :user
  has_many :user_stores
  has_many :users, through: :user_stores
  has_many :items

  def categories(store)
    Category.joins(:items).where(items: { store_id: store.id }).pluck(:name).uniq
  end
end
