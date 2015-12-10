require "test_helper"

class VisitorCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @store = Store.create(name: "Adam's Apples",
                         bio: "We rewl",
                         status: "accepted")
    @cat = Category.create(name: "Fruit")

    item = Item.create(name: "Apple", description: "Gala Apple",
                      price: 6.0,    category_id: @cat.id,
                      store_id: @store.id)
  end

  test "visitor can view item by category" do
    visit '/categories'

    click_link "Fruit"

    assert category_path(@cat), current_path
    within("##{@cat.slug}-items") do
      assert page.has_content?("Apple")
      assert page.has_content?("$6.00")
    end

  end

  test "visitor visits categories through home page" do
    visit '/'

    click_link "Fruit"

    assert category_path(@cat), current_path
    within("##{@cat.slug}-items") do
      assert page.has_content?("Apple")
      assert page.has_content?("$6.00")
    end
  end
end
