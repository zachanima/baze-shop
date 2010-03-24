class AddDummyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :dummy, :boolean
  end

  def self.down
    remove_column :users, :dummy
  end
end
