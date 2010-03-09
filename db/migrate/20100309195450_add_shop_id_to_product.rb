class AddShopIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :shop_id, :integer
    Product.find(:all).each do |product|
      product.shop = product.category.shop
      product.save
    end
  end

  def self.down
    remove_column :products, :shop_id, :integer
  end
end
