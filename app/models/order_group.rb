class OrderGroup < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  has_many :field_values, :dependent => :destroy
  belongs_to :user
  belongs_to :address

  def price
    unless self.dummy
      price = self.orders.collect(&:total_price).compact.inject(0) { |b,i| b + i } unless self.dummy
    end
  end

  def price_with_shipping
    self.price + (self.shipping? ? self.user.shop.shipping_price : 0)
  end

  def shipping?
    self.user.shop.shipping_price and self.price < self.user.shop.shipping_threshold
  end
end
