class AddOptionalToOptionGroup < ActiveRecord::Migration
  def self.up
    add_column :option_groups, :optional, :boolean
  end

  def self.down
    remove_column :option_groups, :optional
  end
end
