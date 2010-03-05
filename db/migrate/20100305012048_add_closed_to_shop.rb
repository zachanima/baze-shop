class AddClosedToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :closed, :boolean
  end

  def self.down
    remove_column :shops, :closed
  end
end
