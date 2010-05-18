class AddCorrespondentToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :correspondent, :string
    Shop.all.each do |shop|
      shop.correspondent = 'os@baze.dk'
      shop.save
    end
  end

  def self.down
    remove_column :shops, :correspondent
  end
end
