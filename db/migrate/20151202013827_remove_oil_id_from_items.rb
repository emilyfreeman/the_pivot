class RemoveOilIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :oil_id
  end
end
