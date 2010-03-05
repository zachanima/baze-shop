class AddClosedToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :closed, :boolean
  end

  def self.down
    add_column :shops, :closed
  end
end
