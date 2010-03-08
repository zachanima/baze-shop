class RenameProductsTableToTemplates < ActiveRecord::Migration
  def self.up
    rename_table :products, :templates
    rename_column :categorizations, :product_id, :template_id
    rename_column :images, :product_id, :template_id
    remove_index :images, "product_id"
    add_index :images, :template_id, :name => "index_images_on_template_id"
  end

  def self.down
    rename_table :templates, :products
    rename_column :categorizations, :template_id, :product_id
    rename_column :images, :template_id, :product_id
    remove_index :images, "template_id"
    add_index :images, :product_id, :name => "index_images_on_product_id"
  end
end
