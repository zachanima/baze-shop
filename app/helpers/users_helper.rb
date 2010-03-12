module UsersHelper
  def attributes_for_import
    options = [:first_name, :last_name, :login, :password, :department, :address, :email, :telephone, :text].collect do |a|
      [a, a]
    end
    options_for_select(options.unshift(['', '']))
  end
end
