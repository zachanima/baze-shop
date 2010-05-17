class Variation < ActiveRecord::Base
  belongs_to :option
  belongs_to :product
  has_and_belongs_to_many :orders
  
  def text_with_price(price = nil, net_price = nil)
    [self.option.text, price ? " +#{price}" : nil, net_price ? " (#{net_price})" : nil].compact.join(' ')
  end
end
