require "test_helper"

class UserRequiredToRegisterBeforeCheckoutTest < ActionDispatch::IntegrationTest
  test "user is required to register" do

    store = Store.create(name: "Adam's Apples",
                               bio: "We rewl",
                               status: "accepted")

    item1 = store.items.create(name: "Apple",
                                description: "Gala Apple",
                                price: 6.0,
                                store_id: store.id)

    visit "/"

    visit items_path

    within(".apple") do
      click_button "Add to Cart"
    end

    visit "/cart"

    assert page.has_content?("Apple")

    click_link "Place Order"

    assert page.has_content?("Please login before placing an order")

  end
end
