class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.references :product

      t.timestamps
    end
    add_index :images, :product_id
  end

  def self.down
    drop_table :images
  end
end
