# As a business admin,
# When I visit the business dashboard,
# I expect to see my business name

class BusinessAdminViewStoreDashboard < ActionDispatch::IntegrationTest
  test "business admin can view business info" do
    admin = create_admin
    store = create_store
    login_admin

    within("#business-info") do
      assert page.has_content? "#{store.name}"
    end
  end

end
