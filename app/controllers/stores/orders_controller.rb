class Stores::OrdersController < ApplicationController
  def index
  end

  def show
    @store = current_user.store
    @order = @store.orders.find(params[:id])
    @item_orders = @store.item_orders.where(order_id: @order.id)
  end
end
