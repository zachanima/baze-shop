module DateMethods
  def created
    created_at.to_s(:short)
  end

  def updated
    updated_at.to_s(:short)
  end
end
