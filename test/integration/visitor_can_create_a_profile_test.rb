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
end
