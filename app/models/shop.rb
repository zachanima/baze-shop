class Shop < ActiveRecord::Base
  has_many :email_addresses, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :user_groups, :dependent => :destroy
  has_many :fields, :dependent => :destroy
  validates_presence_of :link
  validates_uniqueness_of :link

  has_attached_file :logo, :styles => {
    :original => '500x50>' }

  def orders
    Order.all(:order => 'order_group_id DESC').select { |o| o.user.shop === self }
  end

  def templates
    self.categories.collect { |category| category.templates }.flatten
  end

  def conditional_currency
    currency.blank? ? 'kr.' : currency
  end

  def status
    [
      closed ? 'Closed' : nil,
      logo.exists? ? nil : 'No logo',
      self.public ? 'Public' : nil
    ].compact
  end

  def to_param
    self.link
  end

  def locale_text
    case self.locale
      when 'da' then 'Danish'
      when 'en' then 'English'
    end
  end
end
