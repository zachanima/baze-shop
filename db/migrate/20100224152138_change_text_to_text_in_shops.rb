class ChangeTextToTextInShops < ActiveRecord::Migration
  def self.up
    change_column :shops, :text, :text
  end

  def self.down
    change_column :shops, :text, :string
  end
end
