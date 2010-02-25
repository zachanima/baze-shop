class AddCategorizationsOptionsJoin < ActiveRecord::Migration
  def self.up
    create_table :categorizations_options do |t|
      t.references :categorization
      t.references :option
    end
  end

  def self.down
    drop_table :categorizations_options
  end
end
