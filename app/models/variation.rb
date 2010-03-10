class Variation < ActiveRecord::Base
  belongs_to :option
  belongs_to :product
  has_and_belongs_to_many :orders
end
