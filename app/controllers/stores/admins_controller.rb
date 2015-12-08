class Stores::AdminsController < Stores::BaseController

  def new
    @users = User.all
    # respond_with @users
  end

  def create
    byebug
    @user = params
  end

end
