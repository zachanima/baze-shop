class Categorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
  has_and_belongs_to_many :option_groups
  has_and_belongs_to_many :options
end
