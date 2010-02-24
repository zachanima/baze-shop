class AddShopIdToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :shop_id, :integer
  end

  def self.down
    remove_column :categories, :shop_id
  end
end
