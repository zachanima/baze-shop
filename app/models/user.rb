class User < ActiveRecord::Base
  belongs_to :shop
  belongs_to :email_address
  has_many :orders, :dependent => :destroy
  has_many :order_groups, :dependent => :destroy
  has_and_belongs_to_many :user_groups
  validates_presence_of :first_name, :login, :password
  validates_uniqueness_of :login, :scope => :shop_id

  def name
    [self.first_name, self.last_name].join(' ')
  end

  def accepted_orders
    self.order_groups.all(:conditions => { :dummy => false }).collect { |order_group| order_group.orders }.flatten
  end

  def dummy_orders
    self.order_groups.all(:conditions => { :dummy => true }).collect { |order_group| order_group.orders }.flatten
  end

  def waiting_orders
    self.orders.all(:conditions => { :order_group_id => nil })
  end

  def balance
    if self.budget
      balance = self.budget
      self.accepted_orders.each do |order|
        balance -= order.price if order.price
        balance -= ((order.product.print_price ? order.product.print_price : 0) + (order.product.environment_fee ? order.product.environment_fee : 0)) * order.quantity if order.price and order.product
      end
      return balance
    end
  end
end
