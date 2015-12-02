class ItemsController < ApplicationController
  def index
    @items = Item.take(6)
    @categories = Category.all
    @farmers = User.where(role: 1).take(6)
  end

  def show
    @item = Item.find_by(slug: params[:slug])
  end
end
