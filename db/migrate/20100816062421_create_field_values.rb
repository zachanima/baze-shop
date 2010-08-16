class CreateFieldValues < ActiveRecord::Migration
  def self.up
    create_table :field_values do |t|
      t.string :text
      t.references :field
      t.references :order_group
    end
  end

  def self.down
    drop_table :field_values
  end
end
