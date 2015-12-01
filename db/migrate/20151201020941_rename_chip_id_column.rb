class RenameChipIdColumn < ActiveRecord::Migration
  def change
    rename_column :item_orders, :chip_id, :item_id
  end
end
