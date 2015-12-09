class ItemsController < ApplicationController
  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.store_id = current_user.store_id
    if @item.save
      redirect_to store_path(store: current_user.store.slug, id: current_user.store.id)
    else
      render :new
    end
  end

  def index
    @items = Item.all
    @categories = Category.all
  end

  def show
    @item = Item.find_by(slug: params[:slug])
  end

  def destroy
    item = Item.find_by(slug: params[:slug])
    # require 'pry'; binding.pry
    item.destroy
    redirect_to request.referrer 
  end

  private

  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :category_id,
                                 :image,
                                 :description)
  end
end
