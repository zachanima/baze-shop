class AddEmailAddressIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_address_id, :integer
  end

  def self.down
    remove_column :users, :email_address_id
  end
end
