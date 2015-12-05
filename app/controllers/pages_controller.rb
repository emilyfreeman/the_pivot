class PagesController < ApplicationController
  def home
    @items = Item.take(6)
    @categories = Category.all
    @stores = Store.take(6)
  end

  def about
  end
end
