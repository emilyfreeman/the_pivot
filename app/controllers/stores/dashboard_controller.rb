class Stores::DashboardController < Stores::BaseController
  def index
    @store = current_user.store
    @orders = @store.orders
  end
end
