class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :template
  has_many :orders
  has_and_belongs_to_many :images
  has_and_belongs_to_many :option_groups
  has_and_belongs_to_many :options
end
