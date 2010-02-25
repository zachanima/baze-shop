class CreateOptionGroups < ActiveRecord::Migration
  def self.up
    create_table :option_groups do |t|
      t.string :name
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :option_groups
  end
end
