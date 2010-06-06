module DateMethods
  def created
    created_at.date_or_time
  end

  def updated
    updated_at.date_or_time
  end
end
