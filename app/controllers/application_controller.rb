require 'csv'

class ApplicationController < ActionController::Base
  before_filter :find_current_user
  before_filter :find_shop

  helper :all
  protect_from_forgery


  protected
  def authenticate
    authenticate_or_request_with_http_basic do |login, password|
      login == Admin.first.login && password == Admin.first.password
    end
  end

  def find_current_user
    begin
      @current_user = User.find(session[:user_id]) if session[:user_id]
    rescue
      @current_user = nil
    end
  end

  def find_option_group
    @option_group = OptionGroup.find(params[:option_group_id]) if params[:option_group_id]
  end

  def find_shop
    @shop = Shop.find_by_link(params[:shop_id]) if params[:shop_id]
  end

  def notice(url)
    if current_resource.new_record?
      action_text = 'Created'
    elsif current_resource
      action_text = 'Updated'
    else
      action_text = 'Destroyed'
    end
    flash[:notice] = [action_text, current_class_name].join(' ')
    redirect_to(url)
  end

  def error(action)
    if current_resource.new_record?
      action_text = 'Could not create'
    elsif current_resource
      action_text = 'Could not update'
    else
      action_text = 'Could not destroy'
    end
    flash[:error] = [action_text, current_class_name].join(' ')
    render :action => action
  end

  def render_shop
    if @current_user and @current_user.shop === @shop
      render :layout => 'shop'
    else
      session.delete(:user_id)
      redirect_to(login_path(@shop))
    end
  end


  private
  # Find current resource based on priority
  def current_resource
    [ @address,
      @admin,
      @category,
      @change,
      @email_address,
      @image,
      @option,
      @option_group,
      @order,
      @order_group,
      @variation,
      @product,
      @user,
      @shop,
      @product_template ].compact.first
  end

  def current_class_name
    current_resource.class.name.downcase
  end
end
