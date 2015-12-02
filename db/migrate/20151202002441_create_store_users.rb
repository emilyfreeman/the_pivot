class CreateStoreUsers < ActiveRecord::Migration
  def change
    create_table :store_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
