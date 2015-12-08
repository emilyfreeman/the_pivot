require "test_helper"

class UserViewIndexPageTest < ActionDispatch::IntegrationTest
  def setup
    @store = Store.create(name: "Adam's Apples",
                         bio: "We rewl",
                         status: "approved")
    cat = Category.create(name: "Fruit")

    item = Item.create(name: "Apple", description: "Gala Apple",
                      price: 6.0,    category_id: cat.id,
                      store_id: @store.id)
  end

  test "featured items on index page" do
    visit root_path
    within(".featured") do
      assert page.has_content?("Apple")
    end

    within(".top-farmers") do
      assert page
    end
    within(".categories") do
      assert page.has_content?("Fruit")
    end
  end
end
