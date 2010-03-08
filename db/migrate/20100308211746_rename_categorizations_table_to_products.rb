class RenameCategorizationsTableToProducts < ActiveRecord::Migration
  def self.up
    rename_table :categorizations, :products
    rename_table :categorizations_images, :images_products
    rename_table :categorizations_option_groups, :option_groups_products
    rename_table :categorizations_options, :options_products
    rename_column :images_products, :categorization_id, :product_id
    rename_column :option_groups_products, :categorization_id, :product_id
    rename_column :options_products, :categorization_id, :product_id
    rename_column :orders, :categorization_id, :product_id
  end

  def self.down
    rename_table :products, :categorizations
    rename_table :images_products, :categorizations_images
    rename_table :option_groups_products, :categorizations_option_groups
    rename_table :options_products, :categorizations_options
    rename_column :categorizations_images, :product_id, :categorization_id
    rename_column :categorizations_option_groups, :product_id, :categorization_id
    rename_column :categorizations_options, :product_id, :categorization_id
    rename_column :orders, :product_id, :categorization_id
  end
end
