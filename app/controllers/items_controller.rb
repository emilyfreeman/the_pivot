class ItemsController < ApplicationController
  def index
    @items = Item.take(6)
    @categories = Category.all
    @stores = Store.take(6)
  end

  def show
    @item = Item.find_by(slug: params[:slug])
  end
end
