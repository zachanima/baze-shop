class AddNetToEmailAddresses < ActiveRecord::Migration
  def self.up
    add_column :email_addresses, :net, :boolean
    EmailAddress.all.each do |email_address|
      email_address.net = true
      email_address.save
    end
  end

  def self.down
    remove_column :email_addresses, :net
  end
end
