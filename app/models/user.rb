class User < ActiveRecord::Base
  belongs_to :shop
  has_many :orders, :dependent => :destroy
  validates_presence_of :first_name, :login, :password
  validates_uniqueness_of :login, :scope => :shop_id
  acts_as_authentic

  def name
    [self.first_name, self.last_name].join(' ')
  end
end
