class AddCategorizationsImagesJoin < ActiveRecord::Migration
  def self.up
    create_table :categorizations_images, :id => false do |t|
      t.references :categorization
      t.references :image
    end
  end

  def self.down
    drop_table :categorizations_images
  end
end
