class Stores::DashboardController < Stores::BaseController
  def index
    if platform_admin?
      @store = Store.find_by(slug: params[:store])
    else
      @store = current_user.store
    end
    @orders = @store.orders
  end
end
