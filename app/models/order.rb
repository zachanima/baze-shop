class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  belongs_to :order_group
  has_and_belongs_to_many :variations
end
