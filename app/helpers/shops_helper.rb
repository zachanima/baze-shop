module ShopsHelper
  def link_to_users(shop)
    link_to_count(shop.users, shop_users_path(shop))
  end

  def link_to_products(shop)
    link_to_count(shop.products, shop_products_path(shop))
  end

  def truncated_status(shop)
    status = shop.status
    if status.count > 1
      [
        status.shift,
        ', <span class="tooltip" title="',
        status.join(', '),
        '">&hellip;</span>'
      ].join
    else
      status.first
    end
  end
end
