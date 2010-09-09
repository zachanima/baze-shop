class AddShippingAttributesToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :shipping_price, :float
    add_column :shops, :shipping_threshold, :float
  end

  def self.down
    remove_column :shops, :shipping_threshold
    remove_column :shops, :shipping_price
  end
end
