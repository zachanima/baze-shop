class Field < ActiveRecord::Base
  has_many :field_values
  belongs_to :shop
end
