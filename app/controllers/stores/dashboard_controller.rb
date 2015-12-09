class Stores::DashboardController < Stores::BaseController
  def index
    @store = current_user.store
    @orders = @store.orders
  end

  def show
    @store = current_user.store
    @orders = Order.desc_by_date
  end
end
