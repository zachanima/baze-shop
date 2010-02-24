# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_new(str, path)
    link_to("Add new #{str}", path, :class => 'button')
  end
end
