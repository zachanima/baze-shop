class CreateOrdersVariationsJoin < ActiveRecord::Migration
  def self.up
    create_table :orders_variations, :id => false do |t|
      t.references :order
      t.references :variation
    end
  end

  def self.down
    drop_table :orders_variations
  end
end
