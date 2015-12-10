require "test_helper"

class PlatformAdminAcceptDeclineNewStoreTest < ActionDispatch::IntegrationTest
  def setup
    create_platform_admin
    create_pending_store
    @pending_store2 = Store.create(name:"Second Store",
                                   status: "Pending")
    @pending_store3 = Store.create(name:"Third Store",
                                   status: "Pending")
    login_platform_admin
  end

  test "platform admin can accept a store" do
    within("#pending-stores") do
      assert page.has_content?("Pending Farms")
      assert page.has_content?("#{@pending_store.name}")
      assert page.has_content?("#{@pending_store2.name}")
      assert page.has_content?("#{@pending_store3.name}")
    end
save_and_open_page
    first(:link, "Put Store Online").click
  end
end
