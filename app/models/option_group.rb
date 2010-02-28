class OptionGroup < ActiveRecord::Base
  has_many :options, :dependent => :destroy
  has_and_belongs_to_many :categorizations
  validates_presence_of :name
end
