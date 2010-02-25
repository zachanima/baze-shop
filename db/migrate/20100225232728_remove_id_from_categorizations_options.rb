class RemoveIdFromCategorizationsOptions < ActiveRecord::Migration
  def self.up
    remove_column :categorizations_options, :id
  end

  def self.down
    add_column :categorizations_options, :id, :integer
  end
end
