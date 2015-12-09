class Store < ActiveRecord::Base
  has_many :users
  has_many :items
  has_many :item_orders

  has_many :orders, through: :users
  has_many :orders, through: :item_orders
  has_many :categories, through: :items

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: true

  before_validation :generate_slug

  has_attached_file :image, styles: {
    thumb: '100x100#',
    square: '200x200#'
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def generate_slug
    self.slug = self.name.parameterize
  end

  # TODO: Refactor
  def category_names(store)
    Category.joins(:items).where(items: { store_id: store.id }).pluck(:name).uniq
  end
end
