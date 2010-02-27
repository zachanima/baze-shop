class Shop < ActiveRecord::Base
  include DateMethods

  has_many :categories, :dependent => :destroy
  has_many :users, :dependent => :destroy
  validates_presence_of :link

  def products
    self.categories.collect { |category| category.products }.flatten
  end
end
