require 'test_helper'

class BusinessAdminViewStoreDashboardTest < ActionDispatch::IntegrationTest

  test "business admin can view business info" do
    admin = User.create!(username: "someotheradmin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "TestShop")
    store.users << admin
    visit root_path

    within(".nav-wrapper") do
      click_link "Login"
    end

    fill_in "Username", with: "someotheradmin"
    fill_in "Password", with: "password"
    click_button "Login"

    assert dashboard_path, current_path

    click_link "My Store Dashboard"

    assert store_dashboard_index_path(store: store), current_path

    within("#business-info") do
      assert page.has_content? "#{store.name}"
      assert page.has_content? "#{store.bio}"
    end
  end
end
