class AddParcelSizeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :parcel_size, :integer
  end

  def self.down
    remove_column :products, :parcel_size
  end
end
