class AddDummyToOrderGroups < ActiveRecord::Migration
  def self.up
    add_column :order_groups, :dummy, :boolean
    OrderGroup.all.each do |order_group|
      order_group.dummy = false
      order_group.save
    end
  end

  def self.down
    remove_column :order_groups, :dummy
  end
end
