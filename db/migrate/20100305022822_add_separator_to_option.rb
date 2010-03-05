class AddSeparatorToOption < ActiveRecord::Migration
  def self.up
    add_column :options, :separator, :boolean
  end

  def self.down
    remove_column :options, :separator
  end
end
