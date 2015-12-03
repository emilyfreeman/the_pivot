require "test_helper"

class UserCanLoginTest < ActionDispatch::IntegrationTest
  test "user can login" do
    category_1 = Oil.create(name: "Lard")

    Item.create(name: "Slotaitems", price: 20,
                description: "Super yummy", oil_id: category_1.id)

    user = User.create(username: "John", password: "Password")

    visit items_path

    within("#slotaitems") do
      click_button "Add to Cart"
    end

    visit "/"

    within (".right") do
      assert page.has_content?("Login")
      assert page.has_content?("Create Account")
    end

    within(".right") do
      click_link "Login"
    end

    fill_in "Username", with: "John"
    fill_in "Password", with: "Password"

    click_button "Login"

    assert page.has_content? "Logged in as John"
    assert_equal user_path(User.last.id), current_path

    refute page.has_content?("Login")
    assert page.has_content?("Logout")

    visit "/cart"

    assert page.has_content?("Slotaitems")

    within(".right") do
      click_link "Logout"
    end

    refute page.has_content?("Logout")
    assert page.has_content?("Login")
  end

  test 'assert_user_cannot_login_with_incorrect_information' do
    category_1 = Oil.create(name: "Lard")
    Item.create(name: "Slotaitems", price: 20,
                description: "Super yummy", oil_id: category_1.id)
    User.create(username: "John", password: "Password")

    visit items_path
    within(".right") do
      click_link "Login"
    end

    fill_in "Username", with: "Amber"
    fill_in "Password", with: "Password"

    click_button "Login"
    assert page.has_content?("Invalid Login.")
  end
end