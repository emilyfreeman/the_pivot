require "test_helper"

class PlatformAdminTakesStoreOfflineOnlineTest < ActionDispatch::IntegrationTest
  def setup
    create_platform_admin
    create_active_store
    @active_store2 = Store.create(name:"Second Store",
                                   status: "accepted")
    @active_store3 = Store.create(name:"Third Store",
                                   status: "accepted")
    login_platform_admin
  end

  test "platform admin can take a store offline" do
    within("#active-stores") do
      assert page.has_content?("Current Farms")
      assert page.has_content?("#{@active_store.name}")
      assert page.has_content?("#{@active_store2.name}")
      assert page.has_content?("#{@active_store3.name}")
    end

    within("#remove-#{@active_store.id}") do
      click_button "Take Offline"
    end

    within("#active-stores") do
      refute page.has_content?("#{@active_store.name}")
    end

    within("#pending-stores") do
      assert page.has_content?("#{@active_store.name}")
    end

    within("#decline-#{@active_store.id}") do
      click_button "Decline Store"
    end

    within("#pending-stores") do
      refute page.has_content?("#{@active_store.name}")
    end

    within("#declined-stores") do
      assert page.has_content?("#{@active_store.name}")
    end

    within("#pend-#{@active_store.id}") do
      click_button "Make Pending"
    end

    within("#accept-#{@active_store.id}") do
      click_button "Put Online"
    end

    within("#active-stores") do
      assert page.has_content?("#{@active_store.name}")
    end
  end

  test "a store taken offline can not be seen on the website to shop by" do
    
  end
end
