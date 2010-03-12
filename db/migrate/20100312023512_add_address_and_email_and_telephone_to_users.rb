class AddAddressAndEmailAndTelephoneToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :text
    add_column :users, :email, :string
    add_column :users, :telephone, :string
  end

  def self.down
    remove_column :users, :telephone
    remove_column :users, :email
    remove_column :users, :address
  end
end
