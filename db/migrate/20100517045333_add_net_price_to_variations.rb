class AddNetPriceToVariations < ActiveRecord::Migration
  def self.up
    add_column :variations, :net_price, :float
  end

  def self.down
    remove_column :variations, :net_price
  end
end
