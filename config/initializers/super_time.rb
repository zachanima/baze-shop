class Time
  def date_or_time
    self.today? ? self.to_s(:time) : self.strftime('%e %b')
  end
end
