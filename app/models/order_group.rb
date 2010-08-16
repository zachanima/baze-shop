class OrderGroup < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  has_many :field_values, :dependent => :destroy
  belongs_to :user
  belongs_to :address

  def price
    self.orders.collect { |o| o.total_price }.compact.inject(0) { |b,i| b + i } unless self.dummy
  end
end
