class AddProductsUserGroupsJoin < ActiveRecord::Migration
  def self.up
    create_table :products_user_groups, :id => false do |t|
      t.references :product
      t.references :user_group
    end
  end

  def self.down
    drop_table :products_user_groups
  end
end
