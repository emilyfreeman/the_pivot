require "test_helper"

class UserPermissionServiceTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create(username: "admin", password: "password")
    admin.roles.create(name: "business_admin")
    store = Store.create(name: "GoatSoap")
    store.users << admin
    login_admin
  end

  test "a business admin can visit store index" do
    visit stores_path

    assert stores_path, current_path
  end

  test "a business admin can visit store show" do
    store = Store.create(name: "Store",
                         image: "https://cdn3.iconfinder.com/data/icons/pictofoundry-pro-vector-set/512/StoreFront-512.png")

    visit store_path(store: store.slug, id: store.id)

    assert store_path(store), current_path
  end

  test "a business admin can visit items show" do
    item = Item.create!(name: "Thing", price: 8)
    visit item_path(item)

    assert item_path(item), current_path
  end

  test "a business admin can view order" do
    user = User.create(username: "person", password: "password")
    order = Order.create(total_price: 8, user_id: user.id)
    visit order_path(order)

    assert order_path(order), current_path
  end

  test "a business admin can view categories" do
    visit categories_path

    assert categories_path, current_path
  end

  test "a business admin can view specific category show page" do
    cat = Category.create(name: "category")
    Item.create(name: "cat", category_id: cat.id)

    visit category_path(slug: cat.slug)

    assert category_path(slug: cat.slug), current_path
  end
end
