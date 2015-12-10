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

  def edit
    @item = Item.find_by(slug: params[:slug])
  end

  def update
    @item = Item.find_by(slug: params[:slug])
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def index
    all_accepted_items = []
    Item.all.each do |item|
      if item.store.status == "accepted"
        all_accepted_items << item
      end
    end
    @items = all_accepted_items
    @categories = Category.all
  end

  def show
    @item = Item.find_by(slug: params[:slug])
  end

  def destroy
    item = Item.find_by(slug: params[:slug])
    item.destroy
    redirect_to request.referrer
  end

  private

  def item_params
    params.require(:item).permit(:id,
                                 :name,
                                 :price,
                                 :category_id,
                                 :image,
                                 :description)
  end
end
