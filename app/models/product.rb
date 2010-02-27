class Product < ActiveRecord::Base
  include DateMethods

  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations
  validates_presence_of :name
end
