module ShopsHelper
  def category_links
    @shop.categories.collect do |category|
      [
        category.level.times.collect { '-' }.join,
        link_to(category.name, edit_shop_category_path(@shop, category)),
        "(#{link_to('delete', shop_category_path(@shop, category), :confirm => "Delete category #{category.name}?", :method => :delete)})"
      ].join(' ')
    end
  end
end
