class FieldValue < ActiveRecord::Base
  belongs_to :field
  belongs_to :order_group
end
