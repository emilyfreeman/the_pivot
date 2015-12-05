require 'test_helper'

class UserCanViewStoreItemsTest < ActionDispatch::IntegrationTest

  def setup
    fruit = Category.create!(name: "Fruit")
    vegetable = Category.create!(name: "Vegetable")
    store = Store.create!(name: "Slota's farm",
                          bio: "some cool bio")
    apples = fruit.items.create!(name: "Apple")
    oranges = fruit.items.create!(name: "Orange")
    lettuce = vegetable.items.create!(name: "Lettuce")
    carrots = vegetable.items.create!(name: "Carrots")
    store.items.push(apples, oranges, lettuce, carrots)
  end

  test "user can view specific store items index" do
    visit '/slota-s-farm'

    # within(".profile-pic") do
    #   assert page.has_css?("img[src*='#{store.image_url}']")
    # end

    within(".bio") do
      assert page.has_content?("some cool bio")
    end

    within(".greeting") do
      assert page.has_content?("Slota's farm")
    end

    within(".categories") do
      assert page.has_content?("Fruit")
      assert page.has_content?("Vegetable")
    end

    within(".Fruit-items") do
      assert page.has_content?("Apple")
      assert page.has_content?("Orange")
    end

    within(".Vegetable-items") do
      assert page.has_content?("Lettuce")
      assert page.has_content?("Carrots")
    end
  end
end
