require "test_helper"

class UserCanViewIndividualFarmerTest < ActionDispatch::IntegrationTest
  def setup
    user = User.create(first_name: "John",
                       last_name: "Slota",
                       username: "john",
                       password: "password")

    store = Store.create(name: "Adam's Apples",
                               bio: "We rewl",
                               status: "approved")

    store.users << user

    cat = Category.create(name: "fruit")

    store.items.create(name: "Apple",
                       description: "Gala Apple",
                       price: 6.0,
                       category_id: cat.id)
  end

  test "user can view individual farmer through index" do

    visit '/farmers'

    within(".farmers") do
      assert page.has_content?("Adam's Apples")
      assert page.has_content?("We rewl")
      assert page.has_content?("Fruit")
      click_link "Visit Our Farm"
    end

    assert page.has_content?("Adam's apples")
    assert page.has_content?("We rewl")
    assert page.has_content?("Fruit")

  end
end
