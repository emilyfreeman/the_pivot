class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(slug: params[:slug])
    @items = @category.items.select { |item| item.store.status == "accepted"}
  end
end
