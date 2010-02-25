class Category < ActiveRecord::Base
  include DateMethods

  acts_as_nested_set

  has_many :categorizations
  has_many :products, :through => :categorizations
  belongs_to :shop
end
