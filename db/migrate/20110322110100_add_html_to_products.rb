class AddHtmlToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :html, :text
  end

  def self.down
    remove_column :products, :html
  end
end
