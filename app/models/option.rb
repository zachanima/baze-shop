class Option < ActiveRecord::Base
  belongs_to :option_group
  has_many :variations
  has_many :products, :through => :variations
  validates_presence_of :text
end
