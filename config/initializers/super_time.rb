class Time
  def date
    self.strftime('%e %b')
  end

  def date_or_time
    self.today? ? self.to_s(:time) : self.date
  end
end
