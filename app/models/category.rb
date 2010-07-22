class Category < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :shop
  has_many :products
  has_many :templates, :through => :products
  has_and_belongs_to_many :user_groups
end
