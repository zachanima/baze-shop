class AddNetPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :net_price, :float
  end

  def self.down
    remove_column :products, :net_price
  end
end
