class AddSuperToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :super, :boolean
    User.all.each do |user|
      user.super = false
      user.save
    end
  end

  def self.down
    remove_column :users, :super
  end
end
