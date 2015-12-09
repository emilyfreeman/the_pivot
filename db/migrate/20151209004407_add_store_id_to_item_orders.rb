class AddStoreIdToItemOrders < ActiveRecord::Migration
  def change
    add_reference :item_orders, :store, index: true, foreign_key: true
  end
end
