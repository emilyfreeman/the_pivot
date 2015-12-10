require 'test_helper'

class PlatformDashboardTest < ActionDispatch::IntegrationTest
  def setup
    create_platform_admin
    login_platform_admin
  end

  test "as a platform admin, when I log in I am taken to the platform admin dashboard page" do
    assert_equal platform_dashboard_index_path, current_path
    assert page.has_content?("Platform Admin Dashboard")
  end

  test "platform admin can see the list of all active online stores" do
    within("#active-stores") do
      assert page.has_content?("Active Stores")
      assert page.has_content?("@active_store.name")
  end

  test "platform admin can see a list of pending stores" do

  end

  test "platform admin can see a list of declined stores" do

  end
end
