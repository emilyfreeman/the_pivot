require 'test_helper'

class UserCavViewRecentOrdersTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(first_name: "John",
                       last_name: "Slota",
                       username: "john",
                       password: "password")

    @store = Store.create(name: "Adam's Apples",
                               bio: "We rewl",
                               status: "approved")
    @store2 = Store.create(name: "Adam's Apples",
                          bio: "We rewl",
                          status: "approved")
    item1 = @store.items.create(name: "Apple",
                                description: "Gala Apple",
                                price: 6.0,
                                store_id: @store.id)
    item2 = @store.items.create(name: "Banana",
                                description: "This is a banana",
                                price: 1.0,
                                store_id: @store.id)
    item3 = @store.items.create(name: "Bluberry Pie",
                                description: "Delicious",
                                price: 12.0,
                                store_id: @store.id)
    item3 = @store.items.create(name: "Red Candle",
                                description: "this is a cool candle",
                                price: 45.0,
                                store_id: @store2.id)
   item3 = @store.items.create(name: "Mango Peach Salsa",
                               description: "I love salsa",
                               price: 12.0,
                               store_id: @store2.id)

    test "registered user is ab;e to see past orders" do
      within 
    end

  end





end
