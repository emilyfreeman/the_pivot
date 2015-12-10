class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :store
  belongs_to :category

  has_many :item_orders
  has_many :orders, through: :item_orders

  before_save :set_slug

  has_attached_file :image, styles: {
    thumb: '100x100#',
    square: '200x200#'
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :available, -> { where(status: "Available").order(name: :asc) }
  scope :admin_alpha, -> { order(status: :asc).order(name: :asc) }

  def to_param
    slug
  end

  def set_slug
    self.slug = name.downcase.tr(" ", "-")
  end

  def description_type(source)
    if source == "index"
      nil
    elsif source == "show"
      self.description
    else
      self.description
    end
  end
end
