require 'test_helper'

class BusinessAdminViewStoreDashboardTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    @store = Store.create(name: "GoatSoap",
                         bio: "Awesome soaps made by goats.")
    @store.users << admin

    User.create(first_name: "Emily", last_name: "Dowdle", username: "emily", password: "password")

    login_admin

    within(".nav-wrapper") do
      click_link "Profile"
    end

    click_link "My Store Dashboard"
  end

  test "business admin can edit business title" do
    click_link "Edit Store Information"

    fill_in "Name", with: "New Store Name"
    click_button "Update"

    assert store_dashboard_index_path(store: @store), current_path

    within("#business-info") do
      assert page.has_content? "New Store Name"
      assert page.has_content? "#{@store.bio}"
    end
  end

  test "business admin can edit business bio" do
    click_link "Edit Store Information"

    fill_in "Bio", with: "Awesome new bio"
    click_button "Update"

    assert store_dashboard_index_path(store: @store), current_path

    within("#business-info") do
      assert page.has_content? "#{@store.name}"
      assert page.has_content? "Awesome new bio"
    end
  end
end
