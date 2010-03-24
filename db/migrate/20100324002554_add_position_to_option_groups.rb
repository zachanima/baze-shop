class AddPositionToOptionGroups < ActiveRecord::Migration
  def self.up
    add_column :option_groups, :position, :integer
  end

  def self.down
    remove_column :option_groups, :position
  end
end
