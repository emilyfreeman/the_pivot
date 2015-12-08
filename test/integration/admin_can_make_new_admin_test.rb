class NewStoreAdminTest < ActionDispatch::IntegrationTest
  test "business admin can add store admin" do
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "GoatSoap")
    store.users << admin
    login_admin

    visit store_dashboard_index_path(store: store)

    click_link "Add New Store Admin"

    within("#search") do
      fill_in "Username", with: "Em"
    end

    within("#admins") do
      assert page.has_content? "Emily"
      assert page.has_content? "emily"
    end
  end
end
