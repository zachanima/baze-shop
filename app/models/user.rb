class User < ActiveRecord::Base
  include DateMethods

  belongs_to :shop
  validates_presence_of :first_name, :username, :password
end
