class Stores::DashboardController < Stores::BaseController
  def index
    @store = current_user.store
    @orders = Order.desc_by_date
  end

  def show
    @store = current_user.store
    @orders = Order.desc_by_date
  end
end
