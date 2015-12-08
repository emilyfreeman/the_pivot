require "test_helper"

class UserViewsOrderTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Johny", password: "password",
                        first_name: "John", last_name: "Slota", bio: "Hi my name John and this is my bio")
    @user.roles.create(name: "registered_user")
    @order = @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
    @order.items.create(name: "apple", price:34, description:"red delicious apple", status: "available")
  end

  test "a regular user can visit their profile page and see their data" do
    visit login_path
    fill_in("Username", with: "Johny")
    fill_in("Password", with: "password")
    click_button "Login"
    within("#order-history") do
      assert page.has_content? "#{@order.id}"
      first(:link, "View Order Details").click
    end

    within(".order_status") do
      assert page.has_content?("203, Main St, Denver Co. 80223")
    end

    within(".items_ordered") do
      assert page.has_content?("apple")
    end
  end
end
