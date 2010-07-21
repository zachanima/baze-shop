class AddPrintPriceAndEnvironmentFeeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :print_price, :float
    add_column :products, :environment_fee, :float
  end

  def self.down
    remove_column :products, :environment_fee
    remove_column :products, :print_price
  end
end
