class Order < ActiveRecord::Base
  belongs_to :categorization
  belongs_to :user
end
