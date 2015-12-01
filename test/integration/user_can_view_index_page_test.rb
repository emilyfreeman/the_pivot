require 'test_helper'

class UserViewIndexPageTest < ActionDispatch::IntegrationTest
  def setup
    # enum role %w(default business_admin platform_admin)

    user = User.create(first_name: "John",
                       last_name: "Slota",
                       username: "john",
                       password: "password",
                       role: 1)

    store = user.store.create(name: "Adam's Apples")

    store.items.create(name: "Apple",
                       description: "Gala Apple",
                       price: 6,
                       category: "fruit")
  end

  test "featured items on index page" do
    visit root_path

    within(".featured") do
      assert page.has_content?("Apple")
    end

    within(".stores") do
      assert page.has_content?("Adam's Apples")
    end

    within(".categories") do
      assert page.has_content?("Fruit")
    end
  end
end
