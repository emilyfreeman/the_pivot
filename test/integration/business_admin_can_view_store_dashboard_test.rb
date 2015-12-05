# As a business admin,
# When I visit the business dashboard,
# I expect to see my business name

class BusinessAdminViewStoreDashboard < ActionDispatch::IntegrationTest
  test "business admin can view business info" do
    admin = create_admin_and_store.first
    store = admin.store
    login_admin

    visit store_dashboard_index_path(store: store)
    save_and_open_page
    within("#business-info") do
      assert page.has_content? "#{store.name}"
      assert page.has_content? "#{store.bio}"
    end
  end

end
