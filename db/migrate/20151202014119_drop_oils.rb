class DropCategorys < ActiveRecord::Migration
  def change
    drop_table :oils
  end
end
