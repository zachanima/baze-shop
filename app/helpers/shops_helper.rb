module ShopsHelper
  def category_links
    @shop.categories.collect do |category|
      [category.level.times.collect { '-' }.join, link_to(category.name, edit_shop_category_path(@shop, category))].join(' ')
    end
  end
end
