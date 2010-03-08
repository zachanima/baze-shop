class Template < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :categories, :through => :products
  has_many :images, :dependent => :destroy
  validates_presence_of :name
end
