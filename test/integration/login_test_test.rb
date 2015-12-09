require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest

  test "a non registered user can not log in" do
    visit '/'
    click_link "Login"
    fill_in "Username", with: "newname"
    fill_in "Password", with: "newpassword"
    click_button "Login"

    assert_equal current_path, login_path
    assert page.has_content?("Invalid Login. Try Again.")
  end

  test "a registered user can log in" do
    create_user
    login_user
    assert page.has_content?("Logged in as")
  end

end
