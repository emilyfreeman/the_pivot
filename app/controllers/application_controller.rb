class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cart, :authorize!
  helper_method :current_user, :store_admin?, :platform_admin?, :category_arr, :store_permissions, :category_arr, :current_store

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_store
    current_user.store
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def store_admin?
    current_user && "business_admin".in?(current_user.roles.pluck(:name))
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to root_url
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  def category_arr
    Category.all.map { |cat| [cat.name, cat.id] }
  end

  def store_permissions
    current_user && current_user.store_admin? && current_user.store == @store
  end
end
