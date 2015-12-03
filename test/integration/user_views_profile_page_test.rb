require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Johny", password: "password",
                        first_name: "John", last_name: "Slota")
    @user.roles.create(name: "registered_user")
    @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
  end

  test "a regular user can visit their profile page and see their data" do
    visit login_path
    fill_in("Username", with: "Johny")
    fill_in("Password", with: "password")
    click_button "Login"
    visit user_path(@user)
    save_and_open_page
    within("#order-history") do
      assert page.has_content? "Your past orders"
    end
  end
end
