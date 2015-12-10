class BusinessAdminCanViewOwnedStoreOrdersTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create!(username: "admin",
                         password: "password")
    admin.roles.create!(name: "business_admin")
    @store = Store.create!(name: "Wild Honey", status: "accepted")
    second_store = Store.create!(name: "Joes", status: "accepted")
    honey = @store.items.create!(name: "honey", price: 5)
    barley = second_store.items.create!(name: "barley", price: 5)
    @wild_honey_order = admin.orders.create!(total_price: 20)
    @barley_order = admin.orders.create!(total_price: 40)
    @wild_honey_order.item_orders.create(item_id: honey.id,
                                         quantity: 3,
                                         subtotal: 60,
                                         store_id: @store.id)
    @barley_order.item_orders.create!(item_id: barley.id,
                                      quantity: 1,
                                      subtotal: 40,
                                      store_id: second_store.id)
    @store.users << admin
    login_admin
  end

  test "business admin can view orders for their store" do
    visit store_dashboard_index_path(store: @store)

    assert store_dashboard_index_path(store: @store), current_path
    within(".order-#{@wild_honey_order.id}") do
      assert page.has_content?("#{@wild_honey_order.id}")
    end
  end

  test "business admin cannot see orders for other stores" do
    visit store_dashboard_index_path(store: @store)
    assert store_dashboard_index_path(store: @store), current_path

    refute page.has_content?("#{@barley_order.id}")
  end

  test "business admin can view a single order" do
    visit store_dashboard_index_path(store: @store)
    assert store_dashboard_index_path(store: @store), current_path
    first(:link, "View Order Details").click
    assert page.has_content?("Order #{@wild_honey_order.id} Details")
  end
end
