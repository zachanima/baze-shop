class AddTextToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :text, :text
  end

  def self.down
    remove_column :products, :text
  end
end
