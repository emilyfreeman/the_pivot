class Category < ActiveRecord::Base
  has_many :items

  before_create :titleize

  def titleize
    self.name = name.capitalize
  end
end
