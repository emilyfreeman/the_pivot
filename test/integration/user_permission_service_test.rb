require "test_helper"

class UserPermissionServiceTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "emily",
                        password: "password")

    visit root_path
    within(".nav-wrapper") do
      click_link "Login"
    end

    fill_in "Username", with: "emily"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  test "a user can visit store index" do
    visit stores_path

    assert stores_path, current_path
  end

  test "a user can visit store show" do
    store = Store.create(name: "Store",
                         image: "https://cdn3.iconfinder.com/data/icons/pictofoundry-pro-vector-set/512/StoreFront-512.png")

    visit store_path(store: store.slug, id: store.id)

    assert store_path(store), current_path
  end

  test "a user can visit items show" do
    item = Item.create(name: "Thing")
    visit item_path(item)

    assert item_path(item), current_path
  end
end
