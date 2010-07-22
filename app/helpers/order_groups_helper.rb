module OrderGroupsHelper
  def list_order_groups_text
    @shop ? ['List orders of', @shop.name].join(' ') : 'List all orders'
  end

  def link_to_legacy_orders
    if @shop
      link_to(['Legacy orders view of', @shop.name].join(' '), shop_orders_path(@shop))
    else
      link_to('Legacy orders view', orders_path)
    end
  end

  def td_order_group(order_group)
    if order_group.dummy
      '<td>Measure</td>'
    else
      ['<td class="name right-align">#', order_group.id, '</td>'].join
    end
  end

  def td_products(order_group)
    orders = order_group.orders
    if orders.count == 1
      text = String.new
      order = orders.first
      if order.product.nil?
        text = truncated_tooltip(variations_text(order), order.product.name) || order.product.name
      else
        text = 'N/A'
      end
      ['<td>', text, '</td>'].join
    else
      product_names = orders.collect { |order|
        if order.product.nil?
          'N/A'
        else
          [order.product.name, variations_text_with_parentheses(order)].compact.join(' ')
        end
      }.join(', ')
      text = truncated_tooltip(product_names, orders.count)
      ['<td class="right-align">', text, '</td>'].join
    end
  end

  def td_link_to_shop(order_group)
    unless @shop
      shop = order_group.user.shop
      ['<td>', link_to(shop.link.capitalize, shop_order_groups_path(shop)), '</td>'].join
    end
  end

  def user_text(order_group)
    order_group.user.name
  end

  private
  def variations_text_with_parentheses(order)
    variations_text(order).parenthesize
  end

  def variations_text(order)
    order.variations.collect(&:option).collect(&:text).join(', ')
  end
end
