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
end
