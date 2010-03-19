class AddReceiptTextToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :receipt_text, :text
  end

  def self.down
    remove_column :shops, :receipt_text
  end
end
