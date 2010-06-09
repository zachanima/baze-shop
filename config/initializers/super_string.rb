class String
  def parenthesize
    ['(', self, ')'].join unless self.blank?
  end
end
