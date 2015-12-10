require 'test_helper'

class AdminCanUpdateStatusOfAnOrder < ActionDispatch::IntegrationTest
  def setup
    login_jorge
    create_active_store
    Order.create(total_price: 1, user_id: 1, status: "Ordered")
    # Order.create(total_price: 2, user_id: 2, status: "Ordered")
    # Order.create(total_price: 3, user_id: 3, status: "Ordered")
  end

  test "admin can view the store order index" do
    skip
    visit store_orders_path()
    save_and_open_page
  end

  test 'admin can update status of an order' do
    skip
  end
end
