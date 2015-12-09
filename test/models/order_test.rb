require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(username: "Johny", password: "password",
                        first_name: "John", last_name: "Slota", bio: "Hi my name John and this is my bio")
    @user.roles.create(name: "registered_user")
    @order = @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
    @order2 = @user.orders.create(status:"Ordered", total_price: 13, address: "789, Queen St, Denver Co. 80223")
    @order3 = @user.orders.create(status:"Paid", total_price: 234, address: "203, Main St, Denver Co. 80223")
  end

  test "update links works" do
    assert_equal [], @order.update_links
    assert_equal ["mark as paid", "cancel"], @order2.update_links
    assert_equal ["mark as complete", "cancel"], @order3.update_links
  end

  test "status update works" do
    assert_equal "Cancelled", @order.status_update("cancel")
    assert_equal "Paid", @order2.status_update("mark as paid")
    assert_equal "Complete", @order3.status_update("mark as complete")
  end

  test "test scope action works" do
    order1 = Order.scope_action("Ordered")
    order2 = Order.scope_action("Paid")
    order3 = Order.scope_action("Cancelled")

    assert_equal Order.scope_action("Ordered").count, 1
    assert_equal Order.scope_action("Paid").count, 1
    assert_equal Order.scope_action("Cancelled").count, 0
  end

end
