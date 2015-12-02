class Category < ActiveRecord::Base
  before_create :titleize

  def titleize
    self.name = name.capitalize
  end

end
