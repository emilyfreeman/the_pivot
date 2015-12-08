class Stores::AdminsController < Stores::BaseController

  def new
    @users = User.all
    # respond_with @users
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
    @admin_to_be_deleted = User.find(params[:id])
    current_user.store.users.delete(@admin_to_be_deleted)
    @admin_to_be_deleted.store = nil
    redirect_to store_dashboard_index_path
  end
end
