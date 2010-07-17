class UserGroup < ActiveRecord::Base
  belongs_to :shop
  has_and_belongs_to_many :products
  has_and_belongs_to_many :users
end
