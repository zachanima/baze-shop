class AddUserGroupsUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :user_groups_users, :id => false do |t|
      t.references :user_group
      t.references :user
    end
  end

  def self.down
    drop_table :user_groups_users
  end
end
