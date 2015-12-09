require "test_helper"

class UserEditProfileTest < ActionDispatch::IntegrationTest

  def setup
    create_user
    login_user
    @order = @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
    @order2 = @user.orders.create(status:"completed", total_price: 13, address: "789, Queen St, Denver Co. 80223")
  end
  test "a registered user can edit their profile info" do
    click_link "Edit Account"
    fill_in "Username", with: "newname"
    fill_in "Password", with: "newpassword"
    fill_in "Bio", with: "This is my new bio"
    click_button "Update"
    click_link "Logout"
    click_link "Login"
    fill_in "Username", with: "newname"
    fill_in "Password", with: "newpassword"
    click_button "Login"
    
    within("#profile-name") do
      assert page.has_content?("newname")
    end

    within("#user-bio") do
      assert page.has_content?("This is my new bio")
    end

  end
end
