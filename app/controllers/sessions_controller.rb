class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      login_user_or_admin
    else
      flash.now[:error] = "Invalid Login. Try Again."
      render :new
    end
  end


  def destroy
    session.clear
    redirect_to root_path
  end

  private
    def login_user_or_admin
      if @user.platform_admin?
        redirect_to platform_dashboard_index_path
        flash[:notice] = "Welcome Site Admin #{@user.username}"
      else
        flash[:notice] = "Logged in as #{@user.username}"
        redirect_to dashboard_path
      end
    end
end
