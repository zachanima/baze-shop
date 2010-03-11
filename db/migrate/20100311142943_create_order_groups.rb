class CreateOrderGroups < ActiveRecord::Migration
  def self.up
    create_table :order_groups do |t|
      t.references :user
      t.text :text

      t.timestamps
    end
    add_column :orders, :order_group_id, :integer

    Order.find(:all, :conditions => { :accepted => true }).each do |order|
      order_group = OrderGroup.new(:user_id => order.user.id, :created_at => order.created_at)
      order_group.save
      order.order_group_id = order_group.id
      order.save
    end

    remove_column :orders, :accepted
  end

  def self.down
    add_column :orders, :accepted, :boolean

    OrderGroup.find(:all).each do |order_group|
      order_group.orders.each do |order|
        order.accepted = true
        order.save
      end
    end
    
    remove_column :orders, :order_group_id
    drop_table :order_groups
  end
end
