class Task < ActiveRecord::Base
  include DateMethods

  # Prepend text (if any) with separator
  def and_text
    text.blank? ? nil : ['&mdash;', text].join(' ')
  end

  def name_and_text
    [name, and_text].join(' ').gsub('"', '&quot;')
  end
end
