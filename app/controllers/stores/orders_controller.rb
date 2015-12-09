class Stores::OrdersController < ApplicationController
  def index
  end

  def show
    @store = current_user.store
    @order = @store.orders.find(params[:id])
  end
end
