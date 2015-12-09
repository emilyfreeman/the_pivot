require "test_helper"

class VisitorRegisterAndCreateProfileTest < ActionDispatch::IntegrationTest

  test "a visitor can register and create a profile" do
    visit '/'
    click_link "Create Account"
    fill_in "Username", with: "newname"
    fill_in "Password", with: "newpassword"
    click_button "Create Account"

    assert_equal current_path, dashboard_path
    within("#profile-name") do
      assert page.has_content?("newname")
    end
  end

  test "a visitor can not create an account with bad information" do
    visit '/'
    click_link "Create Account"
    fill_in "Username", with: ""
    fill_in "Password", with: ""
    click_button "Create Account"
    assert_equal users_path, current_path
    assert page.has_content?("Password can't be blank, Username can't be blank")
  end

end
