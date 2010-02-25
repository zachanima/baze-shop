class OptionGroup < ActiveRecord::Base
  include DateMethods

  validates_presence_of :name
end
