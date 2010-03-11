class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.text :text
      t.integer :position
      t.references :shop

      t.timestamps
    end
    add_column :order_groups, :address_id, :integer
  end

  def self.down
    drop_table :addresses
    remove_column :order_groups, :address_id
  end
end
