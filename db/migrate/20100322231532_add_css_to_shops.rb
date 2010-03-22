class AddCssToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :css, :text
  end

  def self.down
    remove_column :shops, :css
  end
end
