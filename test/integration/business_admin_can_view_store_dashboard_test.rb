class BusinessAdminViewStoreDashboardTest < ActionDispatch::IntegrationTest
  test "business admin can view business info" do
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "GoatSoap")
    store.users << admin
    login_admin

    assert store_dashboard_index_path(store: store), current_path

    visit store_dashboard_index_path(store: store)
    within("#business-info") do
      assert page.has_content? "#{store.name}"
      assert page.has_content? "#{store.bio}"
    end
  end
end
