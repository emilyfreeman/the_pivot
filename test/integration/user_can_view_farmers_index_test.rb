require "test_helper"

class UserCanViewFarmersIndexTest < ActionDispatch::IntegrationTest
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

  test "user can view farmers index text" do

    visit '/farmers'

    within(".farmers") do
      assert page.has_content?("Adam's Apples")
      assert page.has_content?("We rewl")
      assert page.has_content?("Fruit")
    end

  end
end
