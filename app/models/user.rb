class User < ActiveRecord::Base
  include DateMethods

  belongs_to :shop
  validates_presence_of :first_name, :username, :password
  validates_uniqueness_of :username, :scope => :shop_id

  def name
    [self.first_name, self.last_name].join(' ')
  end
end
