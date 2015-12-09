require 'test_helper'

class NewBusinessAdminTest < ActionDispatch::IntegrationTest
  test "business admin can add store admin" do
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "GoatSoap")
    store.users << admin
    login_admin

    User.create(first_name: "Emily", last_name: "Freeman", username: "emily", password: "password")

    visit store_dashboard_index_path(store: store)

    click_link "Add New Store Admin"

    within(".filter") do
      fill_in "Filter By Username", with: "em"
    end

    within("#emily-section") do
      click_button "Select"
    end

    within("#admins") do
      assert page.has_content? "Emily"
      assert page.has_content? "emily"
    end
  end
end
