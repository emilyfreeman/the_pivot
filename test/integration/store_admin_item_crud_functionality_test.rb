class StoreAdminItemCrudTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    @store = Store.create(name: "GoatSoap")
    @store.users << admin
    login_admin
  end

  test "business admin can add new item" do
    visit store_path(store: @store.id)
save_and_open_page
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
