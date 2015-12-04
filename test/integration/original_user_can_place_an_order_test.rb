require "test_helper"

class UserCanPlaceAnOrderTest < ActionDispatch::IntegrationTest
  test "registered user can place an order" do
    skip
    # TWILIO ERROR, unskip or fix
    category_1 = Category.create(name: "Lard")

    Item.create(name: "Slotaitems",
                price: 20,
                description: "Super yummy",
                category_id: category_1.id)

    User.create(username: "John",
                password: "Password")

    visit "/"

    within(".nav-wrapper") do
      click_link "Login"
    end

    fill_in "Username", with: "John"
    fill_in "Password", with: "Password"

    click_button "Login"

    visit items_path

    within("#all-items") do
      click_button "Add to Cart"
    end

    visit "/cart"
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
