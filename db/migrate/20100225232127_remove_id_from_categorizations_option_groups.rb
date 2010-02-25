class RemoveIdFromCategorizationsOptionGroups < ActiveRecord::Migration
  def self.up
    remove_column :categorizations_option_groups, :id
  end

  def self.down
    add_column :categorizations_option_groups, :id, :integer
  end
end
