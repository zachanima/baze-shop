class Option < ActiveRecord::Base
  belongs_to :option_group

  validates_presence_of :text
end
