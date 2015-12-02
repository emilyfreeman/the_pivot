class AddStoreIdToItem < ActiveRecord::Migration
  def change
    add_reference :items, :store, index: true, foreign_key: true
  end
end
