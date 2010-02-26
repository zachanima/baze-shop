class Category < ActiveRecord::Base
  include DateMethods

  acts_as_nested_set

  belongs_to :shop
  has_many :categorizations
  has_many :products, :through => :categorizations
end
