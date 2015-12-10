class Stores::OrdersController < ApplicationController
  helper_method :ordered_status, :paid_status, :cancelled_status, :complete_status

  def index
    @order_status = params[:scope]
    @orders = current_store.orders.where(status: @order_status)
  end

  def show
    @store = current_store
    @order = @store.orders.find(params[:id])
    @item_orders = @store.item_orders.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order.status_update(params[:new_status])
    if @order.save
      redirect_to :back
    else
      # something
    end
  end

  private

    def ordered_status
      current_store.orders.where(status: "Ordered").count
    end

    def paid_status
      current_store.orders.where(status: "Paid").count
    end

    def cancelled_status
      current_store.orders.where(status: "Cancelled").count
    end

    def complete_status
      current_store.orders.where(status: "Complete").count
    end
end
