module UsersHelper
  def attributes_for_import
    options = [:first_name, :last_name, :login, :password, :department, :address, :email, :telephone, :text].collect do |a|
      [a, a]
    end
    options_for_select(options.unshift(['', '']))
  end

  def list_users_text
    @shop ? ['List users of', @shop.name].join(' ') : 'List all users'
  end

  def link_to_add_user
    link_to('Add user', @shop ? new_shop_user_path(@shop) : new_user_path)
  end

  def link_to_import_users
    link_to('Import users', @shop ? import_shop_users_path(@shop) : import_users_path)
  end

  def link_to_user_name(user)
    link_to(user.name, edit_shop_user_path(user.shop, user))
  end

  def link_to_user_orders(user)
    link_to(user.order_groups.count.zero_text, shop_user_orders_path(user.shop, user))
  end

  def shop_or_department(user)
    @shop ? user.department : link_to(user.shop.link.capitalize, shop_users_path(user.shop))
  end

  def truncated_text(user)
    [truncated_tooltip(user.text)].join unless user.text.blank?
  end
end
