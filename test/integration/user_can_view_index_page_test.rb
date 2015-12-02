require 'test_helper'

class UserViewIndexPageTest < ActionDispatch::IntegrationTest
  def setup
    user = User.create(first_name: "John",
                       last_name: "Slota",
                       username: "john",
                       password: "password",
                       role: 1)
    store = Store.create(name: "Adam's Apples",
                         status: "approved")
    cat = Category.create(name: "fruit")
    StoreUser.create(user_id: user.id,
                     store_id: store.id)
    store.items.create(name: "Apple",
                       description: "Gala Apple",
                       price: 6.0,
                       category_id: cat.id)
  end

  test "featured items on index page" do
    visit root_path

    within(".featured") do
      assert page.has_content?("Apple")
    end

    within(".top_farmers") do
      assert page.has_content?("Adam's Apples")
    end

    within(".categories") do
      assert page.has_content?("Fruit")
    end
  end
end
