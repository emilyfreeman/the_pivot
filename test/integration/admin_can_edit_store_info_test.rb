class BusinessAdminViewStoreDashboardTest < ActionDispatch::IntegrationTest
  test "business admin can edit business info" do
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "GoatSoap",
                         bio: "Awesome soaps made by goats.")
    store.users << admin

    User.create(first_name: "Emily", last_name: "Dowdle", username: "emily", password: "password")

    login_admin

    within(".nav-wrapper") do
      click_link "Profile"
    end

    click_link "My Store Dashboard"

    click_link "Edit Store Information"

    fill_in "Name", with: "New Store Name"
    click_button "Update"

    assert store_dashboard_index_path(store: store), current_path

    within("#business-info") do
      assert page.has_content? "New Store Name"
      assert page.has_content? "#{store.bio}"
    end
  end
end
