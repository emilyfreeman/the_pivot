# As a business admin,
# When I visit the business dashboard,
# I expect to see my business name

class BusinessAdminViewStoreDashboard < ActionDispatch::IntegrationTest
  test "business admin can view business info" do
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")

    store = Store.create(name: "GoatSoap")
    store.users << admin

    login_admin

    visit store_dashboard_index_path(store: store.slug)

    assert store_dashboard_index_path(store: store), current_path
save_and_open_page
    # within("#business-info") do
    #   assert page.has_content? "#{store.name}"
    #   assert page.has_content? "#{store.bio}"
    # end
  end

end
