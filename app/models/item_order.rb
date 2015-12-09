class ItemOrder < ActiveRecord::Base
  belongs_to :item
  belongs_to :order
  belongs_to :store

  def self.create_item_order(order, cart)
    cart.contents.each do |item_id, quantity|
      item_price = Item.find(item_id.to_i).price
      subtotal = item_price * quantity
      store_id = Item.find(item_id.to_i).store_id
      byebug
      ItemOrder.create(order_id: order.id,
                       item_id: item_id,
                       quantity: quantity,
                       subtotal: subtotal,
                       store_id: store_id)
    end
  end
end
