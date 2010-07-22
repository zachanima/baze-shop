class AddCategoriesProductsJoin < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id => false do |t|
      t.references :category
      t.references :product
    end
  end

  def self.down
    drop_table :products_user_groups
  end
end
