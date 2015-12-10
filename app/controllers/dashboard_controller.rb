class DashboardController < ApplicationController
  def index
    @store = current_user.store
    @orders = @store.orders
  end
end
