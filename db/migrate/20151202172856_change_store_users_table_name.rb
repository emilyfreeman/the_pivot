class ChangeStoreUsersTableName < ActiveRecord::Migration
  def change
    rename_table :store_users, :user_stores
  end
end
