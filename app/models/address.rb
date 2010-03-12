class Address < ActiveRecord::Base
  belongs_to :shop
  has_many :orders
end
