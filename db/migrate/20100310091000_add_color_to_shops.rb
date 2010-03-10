class AddColorToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :color, :string
  end

  def self.down
    remove_column :shops, :color
  end
end
