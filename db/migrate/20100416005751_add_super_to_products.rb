class AddSuperToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :super, :boolean
    Product.all.each do |product|
      product.super = false
      product.save
    end
  end

  def self.down
    remove_column :products, :super
  end
end
