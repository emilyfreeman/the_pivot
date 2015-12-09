require "test_helper"

class UserCanPlaceAnOrderTest < ActionDispatch::IntegrationTest
  test "registered user can place an order" do
    user = User.create(username: "john", password: "password")
    user.roles.create(name: "registered_user")

    store = Store.create(name: "Adam's Apples",
                               bio: "We rewl",
                               status: "approved")

    item1 = store.items.create(name: "Apple",
                                description: "Gala Apple",
                                price: 6.0,
                                store_id: store.id)

    visit "/"


    click_link "Login"

    fill_in "Username", with: "john"
    fill_in "Password", with: "password"

    click_button"Login"
    assert page.has_content?("Logged in as john")

    visit items_path


    within(".apple") do
      click_button "Add to Cart"
    end

    visit "/cart"

    assert page.has_content?("Apple")

    click_button "Place Order"

    assert_equal new_order_path, current_path
    fill_in "Address", with: "1 Street"
    click_button "Checkout"

    assert page.has_content?("Order was successfully placed")
    assert page.has_content?("Cart (0)")

    visit "/cart"
    click_button "Place Order"
    fill_in "Address", with: "1 Street"
    click_button "Checkout"

    assert page.has_content?("Cart cannot be empty.")
  end
end
