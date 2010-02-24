class Shop < ActiveRecord::Base
  include DateMethods

  has_many :categories
  has_many :users
  validates_presence_of :link
end
