class RemoveSuperFromProductsAndUsers < ActiveRecord::Migration
  def self.up
    Shop.all.each do |shop|
      user_group = UserGroup.new({ :name => 'Super', :shop_id => shop.id })
      user_group.save
      shop.products.all.each do |product|
        product.user_groups << user_group if product.super
      end
      shop.users.all.each do |user|
        user.user_groups << user_group if user.super
      end
    end
    remove_column :products, :super
    remove_column :users, :super
  end

  def self.down
    add_column :products, :super, :boolean
    add_column :users, :super, :boolean
  end
end
