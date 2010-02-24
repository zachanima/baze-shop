# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def categories_collection(resource = nil)
    if resource.nil?
      resource = @shop.categories
    end
    nested_set_options(resource.roots) { |c| "#{'-' * c.level} #{c.name}" }
  end

  def categories_link_collection(resource = nil)
    if resource.nil?
      resource = @shop.categories
    end
    nested_set_options(resource.roots) { |c| "#{'-' * c.level} #{link_to(c.name, edit_shop_category_path(@shop, c))}" }
  end

  def link_to_new(str, path)
    link_to("Add new #{str}", path, :class => 'button')
  end
end
