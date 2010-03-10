class AddAcceptedToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :accepted, :boolean
  end

  def self.down
    remove_column :orders, :accepted
  end
end
