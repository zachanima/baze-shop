class Shop < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :users, :dependent => :destroy
  validates_presence_of :link
  validates_uniqueness_of :link

  def orders
    self.users.collect { |user| user.orders }.flatten
  end

  def products
    self.categories.collect { |category| category.products }.flatten
  end
end
