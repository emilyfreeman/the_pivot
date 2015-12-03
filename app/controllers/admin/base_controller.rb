class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: '/public/404' unless store_admin?
  end
end
