require 'test_helper'

class BusinessAdminItemCrudTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    @store = Store.create(name: "GoatSoap")
    @store.users << admin
    login_admin
  end

  test "business admin can add new item" do
    cat = Category.create(name: "Stuff")
    visit store_path(store: @store.slug, id: @store)
    click_link "Add New Item"

    fill_in "Name", with: "New thing"
    fill_in "Price", with: "6"
    fill_in "Description", with: "Awesome thing to sell"
    select "Stuff", from: "item_category_id"
    click_button "Create Item"

    assert store_path(store: @store.slug, id: @store.id), current_path

    within(".Stuff-items") do
      assert page.has_content? "New thing"
    end
  end

  test "business admin can delete item" do
    cat = Category.create(name: "Stuff")
    visit store_path(store: @store.slug, id: @store)
    click_link "Add New Item"

    fill_in "Name", with: "New thing"
    fill_in "Price", with: "6"
    fill_in "Description", with: "Awesome thing to sell"
    select "Stuff", from: "item_category_id"
    click_button "Create Item"

    assert store_path(store: @store.slug, id: @store.id), current_path

    click_button "Delete"

    refute page.has_content? "New thing"
  end
end
