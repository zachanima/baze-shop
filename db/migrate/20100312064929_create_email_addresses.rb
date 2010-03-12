class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.string :name
      t.string :text
      t.integer :position

      t.references :shop
    end
  end

  def self.down
    drop_table :email_addresses
  end
end
