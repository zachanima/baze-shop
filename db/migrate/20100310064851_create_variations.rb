class CreateVariations < ActiveRecord::Migration
  def self.up
    rename_table :options_products, :variations
    add_column :variations, :id, :primary_key
    add_column :variations, :price, :float
  end

  def self.down
    rename_table :variations, :options_products
    remove_column :variations, :id
    remove_column :variations, :price
  end
end
