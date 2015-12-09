class Stores::AdminsController < Stores::BaseController
  before_action :current_admin?

  def new
    @users = User.all
  end

  def create
    @user = User.find(params[:user])
    current_user.store.users << @user
    if current_user.store.save
      redirect_to store_dashboard_index_path
    else
      render :new
    end
  end

  def destroy
    current_user.store.users.find(params[:id]).update(store_id: nil)
    redirect_to store_dashboard_index_path
  end

end
