class ChangeStoreUsersTableName < ActiveRecord::Migration
  def change
    rename_table :store_users, :stores_users
  end
end
