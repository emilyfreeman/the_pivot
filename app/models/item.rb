class Item < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  belongs_to :oil_type
  belongs_to :store
  belongs_to :category
  has_many :item_orders
  has_many :orders, through: :item_orders
  before_save :set_slug
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
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
