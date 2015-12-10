class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(slug: params[:slug])
    items = @category.items
    accepted_items = []
    items.each do |item|
      if item.store.status == "accepted"
        accepted_items << item
      end
    end
    @items = accepted_items
  end
end
