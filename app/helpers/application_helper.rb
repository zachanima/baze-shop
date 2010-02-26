# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def categories_collection(resource = nil)
    if resource.nil?
      resource = @shop.categories
    end
    nested_set_options(resource.roots) { |c| "#{'-' * c.level} #{c.name}" }
  end

  def link_to_new(string, path)
    link_to("Add new #{string}", path, :class => 'button')
  end
end
