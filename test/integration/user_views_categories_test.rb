require "test_helper"

class UserViewsCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    cat1 = Category.create(name: "Fruits")
    cat2 = Category.create(name: "Wines")
    cat3 = Category.create(name: "Salsas")
    cat4 = Category.create(name: "Sauces")
    cat5 = Category.create(name: "Meats")
    cat6 = Category.create(name: "Chips")
    cat7 = Category.create(name: "Vegetables")
    cat8 = Category.create(name: "Candles")
    cat9 = Category.create(name: "Pies")
  end

  test "user can view all categories on the category index page" do
    visit '/categories'
    within(".categories") do
      assert page.has_content?("Fruits")
      assert page.has_content?("Wines")
      assert page.has_content?("Salsas")
      assert page.has_content?("Sauces")
      assert page.has_content?("Meats")
      assert page.has_content?("Chips")
      assert page.has_content?("Vegetables")
      assert page.has_content?("Candles")
      assert page.has_content?("Pies")
    end
  end
end
