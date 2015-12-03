class Store < ActiveRecord::Base
  belongs_to :user
  has_many :user_stores
  has_many :users, through: :user_stores
  has_many :items

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = self.name.parameterize
  end

end
