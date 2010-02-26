class OptionGroup < ActiveRecord::Base
  include DateMethods

  has_many :options
  has_and_belongs_to_many :categorizations
  validates_presence_of :name
end