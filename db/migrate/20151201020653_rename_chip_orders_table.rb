class RenameChipOrdersTable < ActiveRecord::Migration
  def change
    rename_table :chip_orders, :item_orders
  end
end
