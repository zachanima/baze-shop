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

  def total_price
    if self.price
      if self.product
        self.price + ((self.product.print_price || 0) + (self.product.environment_fee || 0)) * (self.quantity || 1)
      else
        self.price * (self.quantity || 0)
      end
    end
  end

  def net_price
    net_price = self.product.net_price
    self.variations.each do |variation|
      net_price += variation.net_price if net_price and variation.net_price
    end
    net_price *= self.quantity if net_price
    net_price
  end
end
