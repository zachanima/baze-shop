class User < ActiveRecord::Base
  belongs_to :shop
  has_many :orders, :dependent => :destroy
  validates_presence_of :first_name, :username, :password
  validates_uniqueness_of :username, :scope => :shop_id

  def name
    [self.first_name, self.last_name].join(' ')
  end
end
