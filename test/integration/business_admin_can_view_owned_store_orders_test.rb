class BusinessAdminCanViewOwnedStoreOrdersTest < ActionDispatch::IntegrationTest
  def setup
    admin = User.create!(username: "admin",
                         password: "password")
    shopper = User.create!(username: "shopper",
                           password: "password")
    admin.roles.create!(name: "business_admin")
    shopper.roles.create!(name: "registered_user")
    @store = Store.create!(name: "Wild Honey")
    second_store = Store.create!(name: "Joes", status: "accepted")
    honey = @store.items.create!(name: "honey", price: 5, store_id: @store.id)
    barley = second_store.items.create!(name: "barley", price: 5, store_id: @store.id)
    @order1 = admin.orders.create(status: "Ordered", total_price: 40, user_id: shopper.id)
    @order2 = admin.orders.create(status: "Complete", total_price: 50, user_id: shopper.id)
    @order3 = admin.orders.create(status: "Paid", total_price: 60, user_id: shopper.id)
    @order4 = admin.orders.create(status: "Cancelled", total_price: 70, user_id: shopper.id)
    @order5 = admin.orders.create(status: "Complete", total_price: 80, user_id: shopper.id)
    @item_order1 = @order1.item_orders.create(item_id: honey.id,
                                          order_id: @order1.id,
                                          quantity: 3,
                                          subtotal: 60,
                                          store_id: @store.id)
    @item_order2 = @order2.item_orders.create(item_id: honey.id,
                                          order_id: @order2.id,
                                          quantity: 3,
                                          subtotal: 60,
                                          store_id: @store.id)
    @item_orde3 = @order3.item_orders.create(item_id: honey.id,
                                          order_id: @order3.id,
                                          quantity: 3,
                                          subtotal: 60,
                                          store_id: @store.id)
    @item_order4 = @order4.item_orders.create(item_id: honey.id,
                                          order_id: @order4.id,
                                          quantity: 3,
                                          subtotal: 60,
                                          store_id: @store.id)
    @item_order5 = @order5.item_orders.create(item_id: honey.id,
                                          order_id: @order5.id,
                                          quantity: 3,
                                          subtotal: 60,
                                          store_id: @store.id)
    @wild_honey_order = admin.orders.create!(total_price: 20, status: "Ordered")
    @barley_order = admin.orders.create!(total_price: 40, status: "Complete")
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
    # assert page.has_content?("Order #{@wild_honey_order.id} Details")
  end

  test "business admin can view orders by status" do
    visit store_dashboard_index_path(store: @store)
    click_link "Ordered"
    assert page.has_content?(@order1.id)

    visit store_dashboard_index_path(store: @store)
    click_link "Complete"
    assert page.has_content?(@order2.id)

    visit store_dashboard_index_path(store: @store)
    click_link "Paid"
    assert page.has_content?(@order3.id)

    visit store_dashboard_index_path(store: @store)
    click_link "Cancelled"
    assert page.has_content?(@order4.id)
  end
end
