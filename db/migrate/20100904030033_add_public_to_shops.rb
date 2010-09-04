class AddPublicToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :public, :boolean
  end

  def self.down
    remove_column :shops, :public
  end
end
