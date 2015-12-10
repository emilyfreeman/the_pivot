class Platform::DashboardController < Platform::BaseController
  def index
    @active_stores ||= Store.where(status: "accepted")
    @pending_stores ||= Store.where(status: "Pending")
    @declined_stores ||= Store.where(status: "declined") # will this ||= allow us not to have to re query the database when reloading this page?
  end
end
