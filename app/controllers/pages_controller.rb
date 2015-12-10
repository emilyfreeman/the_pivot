class PagesController < ApplicationController
  def home
    all_accepted_items = []
    Item.all.each do |item|
      if item.store.status == "accepted"
        all_accepted_items << item
      end
    end
    @items = all_accepted_items.take(6)
    @categories = Category.all
    all_accepted_stores = Store.where(status: "accepted")
    @stores = all_accepted_stores.take(6)
  end

  def about
  end
end
