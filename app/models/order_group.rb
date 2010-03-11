class OrderGroup < ActiveRecord::Base
  has_many :orders
  belongs_to :user
end
