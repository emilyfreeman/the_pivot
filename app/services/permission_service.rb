class PermissionService
  extend Forwardable

  attr_reader :user, :controller, :action

  def_delegators :user, :platform_admin?, :store_admin?, :registered_user?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action

    case
    when user.platform_admin? then platform_admin_permissions
    when user.store_admin? then store_admin_permissions
    else
      global_admin_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "pages" && action.in?(%w(home))
    return true if controller == "users" && action.in?(%w(edit index new show create update))
    return true if controller == "items" && action.in?(%w(index show new create edit update destroy))
    return true if controller == "stores" && action.in?(%w(index show new create edit update))
    return true if controller == "orders" && action.in?(%w(new create index show))
    return true if controller == "categories" && action.in?(%w(index show))
    return true if controller == "cart_items" && action.in?(%w(index show create update destroy))
    return true if controller == "orders" && action.in?(%w(index show))
    return true if controller == "platform/dashboard" && action.in?(%w(index))
    return true if controller == "platform/stores" && action.in?(%w(update))
    return true if controller == "stores/dashboard" && action.in?(%w(index show))
    return true if controller == "stores/orders" && action.in?(%w(show index update))
    return true if controller == "stores/items" && action.in?(%w(index show))
  end

  def store_admin_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "pages" && action.in?(%w(home))
    return true if controller == "stores/dashboard" && action.in?(%w(index show))
    return true if controller == "stores/admins" && action.in?(%w(new create index show destroy))
    return true if controller == "users" && action.in?(%w(edit new show create update))
    return true if controller == "items" && action.in?(%w(index show new create edit update destroy))
    return true if controller == "stores" && action.in?(%w(index show new create edit update))
    return true if controller == "orders" && action.in?(%w(new create index show))
    return true if controller == "categories" && action.in?(%w(index show))
    return true if controller == "stores/items" && action.in?(%w(index show))
    return true if controller == "cart_items" && action.in?(%w(index show create update destroy))
    return true if controller == "stores/orders" && action.in?(%w(show index update))
  end

  def global_admin_permissions
    return true if controller == "pages" && action.in?(%w(home))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "stores" && action.in?(%w(index show new create))
    return true if controller == "items" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(edit new show create update))
    return true if controller == "categories" && action.in?(%w(index show))
    return true if controller == "stores/items" && action.in?(%w(index show))
    return true if controller == "cart_items" && action.in?(%w(index show create update destroy))
    return true if controller == "orders" && action.in?(%w(index new create show))
  end
end
