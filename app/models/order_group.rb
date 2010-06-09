class OrderGroup < ActiveRecord::Base
  has_many :orders
  belongs_to :user
  belongs_to :address

  def price
    self.orders.collect { |o| o.price }.compact.inject(0) { |b,i| b + i } unless self.dummy
  end
end
