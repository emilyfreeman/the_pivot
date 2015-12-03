class Store < ActiveRecord::Base
  has_many :users
  # has_many :user_stores
  # has_many :users, through: :user_stores
  has_many :items

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = self.name.parameterize
  end

  def categories(store)
    Category.joins(:items).where(items: { store_id: store.id }).pluck(:name).uniq
  end
end
