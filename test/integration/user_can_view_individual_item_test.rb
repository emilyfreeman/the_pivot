require 'test_helper'

class UserCanViewIndividualItemTest < ActionDispatch::IntegrationTest

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
    visit '/items'

    # within(".profile-pic") do
    #   assert page.has_css?("img[src*='#{store.image_url}']")
    # end

    within(".lettuce") do
      click_button "Add to Cart"
    end

    assert page.has_content?("Lettuce")

  end
end
