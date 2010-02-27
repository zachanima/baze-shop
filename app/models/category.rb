class Category < ActiveRecord::Base
  include DateMethods

  acts_as_nested_set

  belongs_to :shop
  has_many :categorizations, :dependent => :destroy
  has_many :products, :through => :categorizations
end
