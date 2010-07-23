class AddCategoriesProductsJoin < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id => false do |t|
      t.references :category
      t.references :product
    end
    Product.all.each do |product|
      product.categories << Category.find(product.category_id) if product.category_id
      product.save
    end
    remove_column :products, :category_id
  end

  def self.down
    add_column :products, :category_id, :integer
    Product.all.each do |product|
      product.category = product.categories.first
      product.save
    end
    drop_table :categories_products
  end
end
