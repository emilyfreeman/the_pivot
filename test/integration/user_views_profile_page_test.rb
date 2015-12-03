require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Johny", password: "password",
                        first_name: "John", last_name: "Slota", bio: "Hi my name John and this is my bio")
    @user.roles.create(name: "registered_user")
    @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
  end

  test "a regular user can visit their profile page and see their data" do
    visit login_path
    fill_in("Username", with: "Johny")
    fill_in("Password", with: "password")
    click_button "Login"
    within("#order-history") do
      assert page.has_content? "Your past orders"
    end

    within("#user-bio") do
      assert page.has_content?("Hi my name John and this is my bio")
    end
  end
end
