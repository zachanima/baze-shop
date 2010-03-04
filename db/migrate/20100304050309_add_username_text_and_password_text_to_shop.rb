class AddUsernameTextAndPasswordTextToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :username_text, :string
    add_column :shops, :password_text, :string
  end

  def self.down
    remove_column :shops, :username_text
    remove_column :shops, :password_text
  end
end
