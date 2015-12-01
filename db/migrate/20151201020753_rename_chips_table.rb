class RenameChipsTable < ActiveRecord::Migration
  def change
    rename_table :chips, :items
  end
end
