module ProductsHelper
  def truncated_categories(product)
    if product.categories.count > 0
      categories = product.categories
      text = categories.shift.self_and_ancestors.collect(&:name) * ' > '
      tooltip = Array.new
      categories.each do |category|
        tooltip << [category.self_and_ancestors.collect(&:name) * ' > ']
      end
      if tooltip.empty?
        text
      else
        truncated_tooltip(tooltip.join(', '), text)
      end
    end
  end
end
