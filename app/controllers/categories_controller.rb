class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(slug: params[:slug])
    @items = @category.items.map { |item| item if item.store.status == "accepted" }
  end
end
