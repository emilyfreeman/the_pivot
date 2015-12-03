class AddBioToStores < ActiveRecord::Migration
  def change
    add_column :stores, :bio, :string
  end
end
