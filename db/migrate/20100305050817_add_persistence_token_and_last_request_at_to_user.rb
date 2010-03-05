class AddPersistenceTokenAndLastRequestAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :persistence_token, :string
    add_column :users, :last_request_at, :datetime
  end

  def self.down
    remove_column :users, :persistence_token
    remove_column :users, :last_request_at
  end
end
