class Shop < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :users, :dependent => :destroy
  validates_presence_of :link
  validates_uniqueness_of :link

  has_attached_file :logo, :styles => {
    :original => '500x50>' }

  def orders
    self.users.collect { |user| user.orders }.flatten
  end

  def templates
    self.categories.collect { |category| category.templates }.flatten
  end

  def to_param
    self.link
  end
end
