class RemoveStoreIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :store_id
  end
end
