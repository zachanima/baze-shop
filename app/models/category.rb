class Category < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :shop
  has_many :categorizations, :dependent => :destroy
  has_many :templates, :through => :categorizations
end
