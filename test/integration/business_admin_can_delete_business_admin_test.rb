require 'test_helper'

class DeleteBusinessAdminTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    @store = Store.create(name: "GoatSoap")
    @store.users << admin
    login_admin

    User.create(first_name: "Emily", last_name: "Freeman", username: "emily", password: "password")

    visit store_dashboard_index_path(store: @store)

    click_link "Add New Store Admin"

    within(".filter") do
      fill_in "Filter By Username", with: "em"
    end

    within("#emily-section") do
      click_button "Select"
    end
  end

  test "business admin can delete business admin" do
    visit store_dashboard_index_path(store: @store)

    within("#emily-admin") do
      click_button "Delete"
    end

    assert store_dashboard_index_path(store: @store), current_path

    within("#admins") do
      refute page.has_content? "Emily"
      refute page.has_content? "emily"
    end
  end
end
