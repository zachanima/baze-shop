class AddLogoBoxToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :logo_box, :boolean
    Shop.all.each do |shop|
      shop.logo_box = true
      shop.save
    end
  end

  def self.down
    remove_column :shops, :logo_box
  end
end
