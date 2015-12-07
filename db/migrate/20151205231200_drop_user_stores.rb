class DropUserStores < ActiveRecord::Migration
  def change
    drop_table :user_stores
  end
end
