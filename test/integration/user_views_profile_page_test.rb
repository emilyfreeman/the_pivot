require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Johny", password: "password",
                        first_name: "John", last_name: "Slota", bio: "Hi my name John and this is my bio")
    @user.roles.create(name: "registered_user")
    @order = @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
    @order2 = @user.orders.create(status:"completed", total_price: 13, address: "789, Queen St, Denver Co. 80223")
    @order3 = @user.orders.create(status:"completed", total_price: 234, address: "203, Main St, Denver Co. 80223")
    @order4 = @user.orders.create(status:"completed", total_price: 53, address: "203, Main St, Denver Co. 80223")
    @order5 = @user.orders.create(status:"completed", total_price: 134, address: "203, Main St, Denver Co. 80223")
    @order6 = @user.orders.create(status:"completed", total_price: 1678, address: "203, Main St, Denver Co. 80223")
    @order7 = @user.orders.create(status:"completed", total_price: 167, address: "203, Main St, Denver Co. 80223")
  end

  test "a regular user can visit their profile page and see their data" do
    visit login_path
    fill_in("Username", with: "Johny")
    fill_in("Password", with: "password")
    click_button "Login"
    assert @user.registered_user?
    within("#order-history") do
      assert page.has_content? "#{@order7.id}"
      assert page.has_content? "#{@order6.id}"
      refute page.has_content? "#{@order.id}"
    end

    within("#user-bio") do
      assert page.has_content?("Hi my name John and this is my bio")
    end
    refute page.has_content?("My Store Dashboard")

    click_link "View all orders"

    within("#all-orders") do
      assert page.has_content? "#{@order.id}"
    end
  end

  test "a store owner logs in and is taken to their profile page" do
      create_admin_and_store
      login_admin

      assert_equal dashboard_path, current_path
      assert page.has_content?("My Store Dashboard")
  end
end
