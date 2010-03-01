class AddTextToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :text, :text
  end

  def self.down
    remove_column :users, :text
  end
end
