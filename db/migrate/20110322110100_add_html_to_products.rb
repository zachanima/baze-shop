class AddHtmlToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :markup, :text
  end

  def self.down
    remove_column :products, :markup
  end
end
