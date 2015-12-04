require "test_helper"

class VisitorCanViewItemsTest < ActionDispatch::IntegrationTest
  test "visitor can view items test" do
    create_item("Slotaitems", 20, "Super yummy")
    create_item("Trader Joe's BBQ", 15, "I'd trade slota for these!")
    create_item("Dang Coconut", 17, "Dang, these are good")

    visit '/items'

    within(".items") do
      assert page.has_content?("Slotaitems")
      assert page.has_content?("Trader Joe's BBQ")
      assert page.has_content?("Dang Coconut")
    end
  end

  test "visitor can view items by category" do
    create_shop
    visit oils_path

    within("#lard") do
      click_link "Lard"
    end

    assert current_path, "/lard"

    within(".items") do
      assert page.has_content?("Slotaitems")
    end

    click_link "Return to oils"

    within("#coconut-oil") do
      click_link "Coconut Category"
    end

    assert current_path, '/coconut-oil'

    within(".items") do
      assert page.has_content?("Dang Coconut")
    end
  end
end
