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

  def notice(resource, url)
    if resource.new_record?
      action = 'Created'
    elsif resource
      action = 'Updated'
    else
      action = 'Destroyed'
    end
    flash[:notice] = [action, resource.class.name.downcase].join(' ')
    url.is_a?(Symbol) ? (render :action => url) : redirect_to(url)
  end

  def error
    if resource.new_record?
      action = 'Created'
    elsif resource
      action = 'Updated'
    else
      action = 'Destroyed'
    end
    flash[:error] = [action, resource.class.name.downcase].join(' ')
    url.is_a?(Symbol) ? (render :action => url) : redirect_to(url)
  end

  def render_shop
    if @current_user and @current_user.shop === @shop
      render :layout => 'shop'
    else
      session.delete(:user_id)
      redirect_to(login_path(@shop))
    end
  end
end
