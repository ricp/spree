class AddMissingIndexesToTables < ActiveRecord::Migration
  def self.up 
    add_index :creditcards, :address_id
    add_index :orders, :bill_address_id
    add_index :orders, :ship_address_id
    add_index :orders, :user_id 
  end
  def self.down 
    remove_index :creditcards, :address_id
    remove_index :orders, :bill_address_id
    remove_index :orders, :ship_address_id
    remove_index :orders, :user_id 
  end
end
