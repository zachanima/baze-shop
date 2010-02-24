class Category < ActiveRecord::Base
  include DateMethods

  acts_as_nested_set

  belongs_to :shop
end
