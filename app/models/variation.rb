class Variation < ActiveRecord::Base
  belongs_to :option
  belongs_to :product
end
