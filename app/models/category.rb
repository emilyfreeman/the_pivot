class Category < ActiveRecord::Base
  has_many :items
  has_many :stores, through: :items

  before_create :titleize, :set_slug

  def titleize
    self.name = name.titleize
  end

  def set_slug
    self.slug = name.parameterize
  end
end
