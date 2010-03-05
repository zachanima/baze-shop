class Shop < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :users, :dependent => :destroy
  validates_presence_of :link
  validates_uniqueness_of :link

  has_attached_file :logo, :styles => {
    :original => '500x50>' }
  validates_attachment_content_type :logo, :content_type => [
    'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png' ]

  def orders
    self.users.collect { |user| user.orders }.flatten
  end

  def products
    self.categories.collect { |category| category.products }.flatten
  end

  def to_param
    self.link
  end
end
