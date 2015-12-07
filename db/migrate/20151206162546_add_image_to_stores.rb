class AddImageToStores < ActiveRecord::Migration
  def self.up
    add_attachment :stores, :image
  end

  def self.down
    remove_attachment :stores, :image
  end
end
