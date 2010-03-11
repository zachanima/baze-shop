class User < ActiveRecord::Base
  belongs_to :shop
  has_many :orders, :dependent => :destroy
  has_many :order_groups, :dependent => :destroy
  validates_presence_of :first_name, :login, :password
  validates_uniqueness_of :login, :scope => :shop_id

  def name
    [self.first_name, self.last_name].join(' ')
  end

  def accepted_orders
    self.order_groups.collect { |order_group| order_group.orders }.flatten
  end

  def waiting_orders
    self.orders.all(:conditions => { :order_group_id => nil })
  end
end
