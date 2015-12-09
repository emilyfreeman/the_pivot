require "test_helper"

class VisitorCanAddItemsToCartTest < ActionDispatch::IntegrationTest

  test "business admin can add items to cart from index" do
    create_admin_and_store
    @store2 = Store.create(name: "Adam's Apples",
                          bio: "We rewl",
                          status: "approved")
    item1 = @store.items.create(name: "Apple",
                                description: "Gala Apple",
                                price: 6.0,
                                store_id: @store.id)
    item2 = @store.items.create(name: "Banana",
                                description: "This is a banana",
                                price: 1.0,
                                store_id: @store.id)
    item3 = @store.items.create(name: "Bluberry Pie",
                                description: "Delicious",
                                price: 12.0,
                                store_id: @store.id)
    item3 = @store.items.create(name: "Red Candle",
                                description: "this is a cool candle",
                                price: 45.0,
                                store_id: @store2.id)
   item3 = @store.items.create(name: "Mango Peach Salsa",
                               description: "I love salsa",
                               price: 12.0,
                               store_id: @store2.id)


    visit items_path

    within(".right") do
      assert page.has_content?("Cart (0)")
    end

    within(".mango-peach-salsa") do
      click_button "Add to Cart"
    end

    assert page.has_content?("Added Mango Peach Salsa to cart.")
    assert page.has_content?("Cart (1)")

    within(".right") do
      click_link "Cart"
    end

    assert_equal cart_items_path, current_path

    assert page.has_content?("Mango Peach Salsa")
    assert page.has_content?("12")
    assert page.has_content?("I love salsa")
    assert page.has_content?("Total: $12")
  end

  # test "can add multiple items to cart" do
  #   @user = User.create(first_name: "John",
  #                      last_name: "Slota",
  #                      username: "john",
  #                      password: "password")
  #
  #   @store = Store.create(name: "Adam's Apples",
  #                              bio: "We rewl",
  #                              status: "approved")
  #   @store2 = Store.create(name: "Adam's Apples",
  #                         bio: "We rewl",
  #                         status: "approved")
  #   item1 = @store.items.create(name: "Apple",
  #                               description: "Gala Apple",
  #                               price: 6.0,
  #                               store_id: @store.id)
  #   item2 = @store.items.create(name: "Banana",
  #                               description: "This is a banana",
  #                               price: 1.0,
  #                               store_id: @store.id)
  #   item3 = @store.items.create(name: "Bluberry Pie",
  #                               description: "Delicious",
  #                               price: 12.0,
  #                               store_id: @store.id)
  #   item3 = @store.items.create(name: "Red Candle",
  #                               description: "this is a cool candle",
  #                               price: 45.0,
  #                               store_id: @store2.id)
  #   item3 = @store.items.create(name: "Mango Peach Salsa",
  #                               description: "I love salsa",
  #                               price: 12.0,
  #                               store_id: @store2.id)
  #   visit items_path
  #
  #   assert page.has_content?("Cart (0)")
  #
  #   within(".banana") do
  #     click_button "Add to Cart"
  #   end
  #
  #   assert page.has_content?("Added Banana to cart.")
  #   assert page.has_content?("Cart (1)")
  #
  #   within(".red-candle") do
  #     click_button "Add to Cart"
  #   end
  #
  #   within(".right") do
  #     click_link "Cart"
  #   end
  #
  #   assert_equal cart_items_path, current_path
  #
  #   assert page.has_content?("Banana")
  #   assert page.has_content?("1")
  #   assert page.has_content?("This is a banana")
  #
  #   assert page.has_content?("Red Candle")
  #   assert page.has_content?("45")
  #   assert page.has_content?("this is a cool candle")
  #
  #   assert page.has_content?("Total: $46")
  # end
  #
  # test "user can update cart" do
  #   @user = User.create(first_name: "John",
  #                      last_name: "Slota",
  #                      username: "john",
  #                      password: "password")
  #
  #   @store = Store.create(name: "Adam's Apples",
  #                              bio: "We rewl",
  #                              status: "approved")
  #   @store2 = Store.create(name: "Adam's Apples",
  #                         bio: "We rewl",
  #                         status: "approved")
  #   item1 = @store.items.create(name: "Apple",
  #                               description: "Gala Apple",
  #                               price: 6.0,
  #                               store_id: @store.id)
  #   item2 = @store.items.create(name: "Banana",
  #                               description: "This is a banana",
  #                               price: 1.0,
  #                               store_id: @store.id)
  #   item3 = @store.items.create(name: "Bluberry Pie",
  #                               description: "Delicious",
  #                               price: 12.0,
  #                               store_id: @store.id)
  #   item3 = @store.items.create(name: "Red Candle",
  #                               description: "this is a cool candle",
  #                               price: 45.0,
  #                               store_id: @store2.id)
  #   item3 = @store.items.create(name: "Mango Peach Salsa",
  #                               description: "I love salsa",
  #                               price: 12.0,
  #                               store_id: @store2.id)
  #   visit items_path
  #
  #   assert page.has_content?("Cart (0)")
  #
  #   within(".banana") do
  #     click_button "Add to Cart"
  #   end
  #
  #   assert page.has_content?("Added Banana to cart.")
  #   assert page.has_content?("Cart (1)")
  #
  #   visit '/cart_items'
  #   click_button "add"
  #
  #
  #   assert page.has_content?("Successfully added one Banana to your cart.")
  #   assert page.has_content?("Cart (2)")
  #
  #   click_button "remove"
  #
  #   assert page.has_content?("Successfully removed one Banana from your cart.")
  #   assert page.has_content?("Cart (1)")
  #
  #   click_link "Remove"
  #
  #   assert page.has_content?("Successfully removed Banana from your cart.")
  #   assert page.has_content?("Cart (0)")

  end

end
