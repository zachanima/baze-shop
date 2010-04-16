class EmailAddress < ActiveRecord::Base
  belongs_to :shop
  has_many :users
end
