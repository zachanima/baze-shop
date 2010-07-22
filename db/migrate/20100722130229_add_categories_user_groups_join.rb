class AddCategoriesUserGroupsJoin < ActiveRecord::Migration
  def self.up
    create_table :categories_user_groups, :id => false do |t|
      t.references :category
      t.references :user_group
    end
  end

  def self.down
    drop_table :categories_user_groups
  end
end
