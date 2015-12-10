require 'test_helper'

class PlatformDashboardTest < ActionDispatch::IntegrationTest
  def setup
      create_platform_admin
      create_active_store
      create_pending_store
      create_declined_store
      login_platform_admin
  end

  test "as a platform admin, when I log in I am taken to the platform admin dashboard page" do
    assert_equal platform_dashboard_index_path, current_path
    assert page.has_content?("Platform Admin Dashboard")
  end

  test "platform admin can see a list of pending stores" do
    within("#active-stores") do
      assert page.has_content?("Current Farms")
      assert page.has_content?("#{@active_store.name}")
    end
    within("#pending-stores") do
      assert page.has_content?("Pending Farms")
      assert page.has_content?("#{@pending_store.name}")
    end
    within("#declined-stores") do
      assert page.has_content?("Declined Farms")
      assert page.has_content?("#{@declined_store.name}")
    end
  end

end
