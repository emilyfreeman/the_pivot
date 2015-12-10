require "test_helper"

class UserViewsSingleStoreItemTest < ActionDispatch::IntegrationTest

  def setup
    @store = Store.create(name: "Adam's Apples",
                         bio: "We rewl",
                         status: "accepted")
    cat = Category.create(name: "fruit")

    item = Item.create(name: "Apple", description: "Gala Apple",
                      price: 6.0,    category_id: cat.id,
                      store_id: @store.id)
  end

  test "user can visit a individual store item" do
    visit "adam-s-apples/items/#{@store.items.first.id}"
    within("#item-name") do
      assert page.has_content?("Apple")
    end

    within("#item-name") do
      assert page.has_content?("Gala Apple")
    end

    within("#item-name") do
      assert page.has_content?("6.0")
    end

    within("#item-name") do
      assert page.has_content?("Fruit")
    end
  end
end
