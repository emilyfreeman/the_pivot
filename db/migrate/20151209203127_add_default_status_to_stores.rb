class AddDefaultStatusToStores < ActiveRecord::Migration
  def change
    change_column :stores, :status, :string, default: "Pending"
  end
end
