class OptionGroup < ActiveRecord::Base
  include DateMethods

  has_many :options
  validates_presence_of :name
end
