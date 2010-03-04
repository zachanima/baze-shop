class Product < ActiveRecord::Base
  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations
  has_many :images, :dependent => :destroy
  validates_presence_of :name
end
