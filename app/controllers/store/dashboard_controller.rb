class Stores::DashboardController < Admin::BaseController
  def index
    @store = current_user.store
    @orders = Order.desc_by_date
  end
end
