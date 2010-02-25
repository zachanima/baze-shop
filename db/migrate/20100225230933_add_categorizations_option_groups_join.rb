class AddCategorizationsOptionGroupsJoin < ActiveRecord::Migration
  def self.up
    create_table :categorizations_option_groups do |t|
      t.references :categorization
      t.references :option_group
    end
  end

  def self.down
    drop_table :categorizations_option_groups
  end
end
