class AddLocaleToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :locale, :string
  end

  def self.down
    remove_column :shops, :locale
  end
end
