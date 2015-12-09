require 'test_helper'

class PlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  def setup
    create_platform_admin
    login_platform_admin
  end

  test "as a platform admin, when I log in I am taken to the platform admin dashboard page" do
    assert platformadmin_dashboard_path, current_path
  end
end
