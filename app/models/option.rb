class Option < ActiveRecord::Base
  belongs_to :option_group
  has_and_belongs_to_many :categorizations
  validates_presence_of :text
end
