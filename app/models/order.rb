class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  belongs_to :order_group
  has_and_belongs_to_many :variations

  def update_price
    self.price = self.product.price
    self.variations.each do |variation|
      self.price += variation.price if self.price and variation.price
    end
    self.price *= self.quantity if self.price
    self.save
  end
end
